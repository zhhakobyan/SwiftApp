//
//  URLSessionManagerTests.swift
//  SampleTests
//
//  Created by Zhanna on 28.01.24.
//

import Foundation
import XCTest
import Combine
@testable import Sample

class URLSessionManagerTests: XCTestCase {

    func test_init() {
        let request = URLRequest(url: URL(string: "http://any-url.com")!)
        let sessionManager = MockURLSessionManager(urlRequest: request)

        XCTAssertEqual(sessionManager.request, request)
    }

    func test_fetch_correctURL () {
        let request = URLRequest(url: Bundle.main.url(forResource: "fullResponse", withExtension: "json")!)
        let sessionManager = MockURLSessionManager(urlRequest: request)
        let movieRouting = MovieListParameter(query: "hello")
        let result: AnyPublisher<[MovieElement], Error> = sessionManager.fetch(movieRouting)

        XCTAssertNotNil(result)
    }
}
