//
//  DataFetchManager.swift
//  Sample
//
//  Created by Zhanna on 27.01.24.
//

import Combine

class DataFetchManager {

    let manager: FetchManagerProtocol

    init(with fetchManager: FetchManagerProtocol) {
        manager = fetchManager
    }

    func execute<T: Decodable, R: Routing, E: Error>(_ route: R, errorType: E.Type) -> AnyPublisher<T, Error> {
        return manager.fetch(route)
    }
}
