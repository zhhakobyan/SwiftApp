//
//  MovieViewModel.swift
//  Sample
//
//  Created by Zhanna on 27.01.24.
//

import Foundation

struct MovieViewModel {
    let name: String
    let url: URL?
    let imageUrl: URL?
    let type: String
    let language: String

    init(movie: MovieElement) {
        name = movie.movie.name ?? ""

        if let urlString = movie.movie.url {
            url = URL(string: urlString)
        } else {
            url = nil
        }

        if let imageUrlString = movie.movie.image?.medium {
            imageUrl = URL(string: imageUrlString)
        } else {
            imageUrl = nil
        }

        switch movie.movie.type {
        case .none:
            type = ""
        case .some(.value(let value)):
            type = value ?? ""
        }

        switch movie.movie.language {
        case .none:
            language = ""
        case .some(.value(let movieLanguage)):
            language = movieLanguage ?? ""
        }
    }
}
