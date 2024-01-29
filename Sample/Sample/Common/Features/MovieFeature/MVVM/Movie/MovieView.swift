//
//  MovieView.swift
//  Sample
//
//  Created by Zhanna on 27.01.24.
//

import SwiftUI

struct MovieView: View {
    @State var viewModel: MovieViewModel

    var body: some View {
        VStack(alignment: .center, spacing: ProjectLayout.indent24, content: {
            Text(viewModel.name)
            Text(viewModel.type)
            Text(viewModel.language)
            if let destinationUrl = viewModel.url {
                Link("link", destination: destinationUrl)
            }
            if let imageUrl = viewModel.imageUrl {
                AsyncImage(url: imageUrl)
            }
        })
    }
}

