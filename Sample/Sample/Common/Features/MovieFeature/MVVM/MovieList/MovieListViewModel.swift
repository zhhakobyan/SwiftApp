//
//  MovieListViewModel.swift
//  Sample
//
//  Created by Zhanna on 27.01.24.
//

import Foundation
import Combine

final class MovieListViewModel: ObservableObject {
    @Published private(set) var state = State.loadingList
    private var bag = Set<AnyCancellable>()
    private let input = PassthroughSubject<Event, Never>()
    private var service: DataFetchManager

    init(service: DataFetchManager) {
        self.service = service
    }

    private func fetch(service: DataFetchManager, query: String) {
        Publishers.system(
            initial: state,
            reduce: Self.reduce,
            scheduler: RunLoop.main,
            feedbacks: [
                Self.whenLoading(service: service, query: query),
                Self.userInput(input: input.eraseToAnyPublisher())
            ]
        )
        .assign(to: \.state, on: self)
        .store(in: &bag)
    }

    deinit {
        bag.removeAll()
    }

    func send(event: Event) {
        switch event {
        case .onAppear(let query):
            state = State.loadingList
            fetch(service: self.service, query: query)
        default:
            break
        }
    }
}

extension MovieListViewModel {
    // System states
    enum State {
        case loadingList
        case loadedList([MovieElement])
        case error(Error)
        case empty
    }

    // UI events
    enum Event {
        case onAppear(String)
        case onDataLoaded([MovieElement])
        case onFailedToLoadData(Error)
    }
}

extension MovieListViewModel {
    // Reduce specifies how the state changes in response to an event
    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .loadingList:
            switch event {
            case .onAppear:
                return state
            case .onDataLoaded(let list):
                return list.isEmpty ? .empty : .loadedList(list)
            case .onFailedToLoadData(let error):
                return .error(error)
            }
        default:
            return state
        }
    }

    static func whenLoading(service: DataFetchManager, query: String) -> Feedback<State, Event> {
        Feedback {(state: State) -> AnyPublisher<Event, Never> in
            switch state {
            case .loadingList:
                return service.manager
                    .fetch(MovieListParameter(query: query))
                    .map(Event.onDataLoaded)
                    .catch { Just(Event.onFailedToLoadData($0)) }
                    .eraseToAnyPublisher()
            default:
                return Empty().eraseToAnyPublisher()
            }
        }
    }

    static func userInput(input: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in input }
    }
}
