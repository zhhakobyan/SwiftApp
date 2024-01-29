//
//  MovieListViewModelTests.swift
//  SampleTests
//
//  Created by Zhanna on 28.01.24.
//

@testable import Sample
import Combine
import XCTest

final class MovieListViewModelTests: XCTestCase {
    var service: DataFetchManager!
    var viewModel: MovieListViewModel!
    private var bag = Set<AnyCancellable>()

    func test_send_onAppear_withEmptyList() throws {

        let request = URLRequest(url: Bundle.main.url(forResource: "fullResponse", withExtension: "json")!)

        service = DataFetchManager(with: MockURLSessionManager(urlRequest: request))

        // Initilize view model
        viewModel = MovieListViewModel(service: service)
        viewModel.send(event: MovieListViewModel.Event.onAppear("girlaaaas"))

        let statePublisher = viewModel.$state
            .collect(2)
            .first()

        let stateArrays = try awaitPublisher(statePublisher)
        let state = stateArrays.last
        XCTAssertEqual(stateArrays.count, 2)

        switch state {
        case .empty:
            XCTAssertTrue(true)
        default:
            // Fail if state differs
            XCTFail("Expected to be empty, but was \(String(describing: state))")
        }
    }

    func test_send_onAppear_withLoadedList() throws {
        let request = URLRequest(url: Bundle.main.url(forResource: "fullResponse", withExtension: "json")!)

        service = DataFetchManager(with: MockURLSessionManager(urlRequest: request))

        // Initilize view model
        viewModel = MovieListViewModel(service: service)
        viewModel.send(event: MovieListViewModel.Event.onAppear("girls"))

        let statePublisher = viewModel.$state
            .collect(2)
            .first()

        let stateArrays = try awaitPublisher(statePublisher)
        let state = stateArrays.last
        XCTAssertEqual(stateArrays.count, 2)

        switch state {
        case .loadedList(let list):
            XCTAssertTrue(list.count > 0)
        default:
            // Fail if state differs
            XCTFail("Expected to be empty, but was \(String(describing: state))")
        }
    }
}
