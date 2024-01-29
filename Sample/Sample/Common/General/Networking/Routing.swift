//
//  Routing.swift
//  Sample
//
//  Created by Zhanna on 27.01.24.
//

import Foundation

protocol Routing {
    var baseURLString: String { get }
    var method: RequestType { get }
    var routePath: String { get }
    var parameters: [String: Any]? { get }
    var encoding: ParameterEncoding { get }
    var headers: [String: String]? { get }
    var urlRequest: URLRequest? { get }
}

extension Routing {
    var baseURLString: String {
        return projectBaseURL
    }

    var method: RequestType {
        return .GET
    }

    var routePath: String {
        return ""
    }

    var parameters: [String: Any]? {
        return nil
    }

    var encoding: ParameterEncoding {
        return ParameterEncoding.json
    }

    var headers: [String: String]? {
        return nil
    }

    var urlRequest: URLRequest? {
        let baseURLStirng = baseURLString

        guard var url = URL(string: baseURLStirng) else {
#if DEV
            print("cannot create URL")
#endif
            return nil
        }

        if !routePath.isEmpty {
            let encoded = routePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            url.appendPathComponent(encoded ?? "")
        }
        guard let newUrl = URL(string: url.absoluteString.removingPercentEncoding ?? url.absoluteString) else {
#if DEV
            print("cannot create removingPercentEncoding URL")
#endif
            return nil
        }

        var urlRequest = URLRequest(url: newUrl)
        urlRequest.httpMethod = method.rawValue

        if let headers = self.headers {
            for (key, value) in headers {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }

        if let parameters = self.parameters {
            do {
                urlRequest = try encoding.encode(request: urlRequest, parameters: parameters)
            } catch {
#if DEV
                print("parameters encoding issue")
#endif
            }
        }

        return urlRequest
    }
}

enum RequestType: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum ParameterEncoding {
    case json

    func encode(request: URLRequest, parameters: [String: Any]?) throws -> URLRequest {
        guard let parameters = parameters else { return request }

        var request = request
        var encodingError: NSError?

        switch self {
        case .json:
            do {
                let options = JSONSerialization.WritingOptions()
                let data = try JSONSerialization.data(withJSONObject: parameters, options: options)

                if request.value(forHTTPHeaderField: "Content-Type") == nil {
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }

                request.httpBody = data
            } catch {
                encodingError = error as NSError
            }
        }

        guard encodingError == nil else { throw encodingError! }
        return request
    }
}
