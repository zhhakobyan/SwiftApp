//
//  CompositionRoot.swift
//  Sample
//
//  Created by Zhanna on 27.01.24.
//

let projectBaseURL = "https://api.tvmaze.com/"
let networkSessionManager = URLSessionManager()
let movieService = DataFetchManager(with: networkSessionManager)
let movieViewModel = MovieListViewModel(service: movieService)
