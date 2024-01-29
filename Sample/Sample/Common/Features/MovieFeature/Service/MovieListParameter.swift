//
//  MovieListParameter.swift
//  Sample
//
//  Created by Zhanna on 27.01.24.
//

import Foundation

struct MovieListParameter {
    let query: String
}

extension MovieListParameter: Routing {
    var routePath: String {
        return "search/shows?q=\(query)"
    }
}
