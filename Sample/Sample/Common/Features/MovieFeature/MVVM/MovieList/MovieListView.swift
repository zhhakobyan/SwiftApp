//
//  MovieListView.swift
//  Sample
//
//  Created by Zhanna on 27.01.24.
//

import Foundation
import SwiftUI

struct MovieListView: View {
    @ObservedObject var viewModel: MovieListViewModel
    @State private var isShowingDetailView = false
    @State private var query: String = String(localized: "cars")
    
    let navigationTitle = "Search"
    let retryString = String(localized: "retry", comment: "")
    let noResultString = String(localized: "no results", comment: "inquiry not found")
    let statusString = String(localized: "Status", comment: "")
    let imageMaxWidth = 70.0
    let imageMaxHeight = 70.0
    let textFontSize = 18.0
    
    var body: some View {
        content.onAppear {
            viewModel.send(event: .onAppear(query))
        }
    }

    private var content: some View {
        switch viewModel.state {
        case .loadingList:
            return Spinner(isAnimating: true, style: .large).eraseToAnyView()
        case .loadedList(let list):
            return loadedListView(list: list).eraseToAnyView()
        case .error(let error):
            return errorView(error: error).eraseToAnyView()
        case .empty:
            return emptyResultsView().eraseToAnyView()
        }
    }

    private func loadedListView(list: [MovieElement]) -> some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: ProjectLayout.indent32) {
                    searchHeader(query: $query)
                    ForEach(list) { currentItem in
                        elementView(movie: currentItem)
                    }
                }
                .padding()
            }
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func elementView(movie: MovieElement) -> some View {
        NavigationLink(destination: MovieView(viewModel: MovieViewModel(movie: movie))) {
            HStack(spacing: ProjectLayout.indent32, content: {
                HStack {
                    AsyncImage(
                        url: URL(string: movie.movie.image?.medium ?? ""),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                 .frame(maxWidth: imageMaxWidth, maxHeight: imageMaxHeight)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    
                    VStack(alignment: .leading) {
                        Text(movie.movie.name ?? "")
                            .font(.system(size: textFontSize, weight: .bold))
                            .padding(.bottom, ProjectLayout.indent8)
                        Text("\(statusString): \(movie.movie.status?.rawValue ?? "")")
                    }
                    Spacer()
                }
            })
        }
    }

    private func searchHeader(query: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: ProjectLayout.indent24, content: {
            SearchView(text: query, searchButtonHandler: {
                viewModel.send(event: .onAppear(query.wrappedValue))
            })
        })
    }

    private func emptyResultsView() -> some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: ProjectLayout.indent24) {
                    searchHeader(query: $query)
                    Text(noResultString)
                    Spacer()
                }
                .padding()
            }
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func errorView(error: Error) -> some View {
        return EmptyContentText(title: error.localizedDescription,
                                buttonTitle: retryString) {
            viewModel.send(event: .onAppear(query))
        }
    }
}

