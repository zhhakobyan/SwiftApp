//
//  FetchManagerProtocol.swift
//  Sample
//
//  Created by Zhanna on 27.01.24.
//

import Combine

protocol FetchManagerProtocol {
    func fetch<T: Decodable, R: Routing>(_ routing: R) -> AnyPublisher<T, Error>
}
