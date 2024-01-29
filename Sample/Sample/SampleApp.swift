//
//  SampleApp.swift
//  Sample
//
//  Created by Zhanna on 26.01.24.
//

import SwiftUI

@main
struct SampleApp: App {
    var body: some Scene {
        WindowGroup {
            MovieListView(viewModel: movieViewModel)
        }
    }
}
