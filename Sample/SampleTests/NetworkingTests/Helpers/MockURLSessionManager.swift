//
//  MockURLSessionManager.swift
//  SampleTests
//
//  Created by Zhanna on 28.01.24.
//

import Foundation
import Combine
@testable import Sample

final class MockURLSessionManager: FetchManagerProtocol {

    var request: URLRequest?

    init(urlRequest: URLRequest) {
        request = urlRequest
    }

    func fetch<T: Decodable, R: Routing>(_ routing: R) -> AnyPublisher<T, Error> {
        let urlSession = URLSession(configuration: .default)
#if DEBUG
        print(routing.urlRequest ?? "urlRequest is nil")
#endif
        guard let url = routing.urlRequest else {
            fatalError("Could not create url")
        }

        return urlSession.dataTaskPublisher(for: url)
            .mapError { $0 as Error }
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

