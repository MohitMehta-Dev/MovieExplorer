//
//  MovieListView.swift
//  Alongside
//
//  Created by Mohit Mehta on 17/08/25.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var viewModel: MovieListViewModel
    
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading movies...")
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text(error).foregroundColor(.red)
                        movieList
                    }
                } else {
                    movieList
                }
            }
            .navigationTitle("Movies")
            .task { await viewModel.fetchMovies() }
            .refreshable { await viewModel.fetchMovies() }
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailView(movie: movie)
            }
            .searchable(text: $viewModel.searchedText,
                        placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: viewModel.searchedText) { _ in
                viewModel.getSearchResults()
            }
        }
    }
    
    private var movieList: some View {
        List(viewModel.movies) { movie in
            NavigationLink(value: movie) {
                MovieRowView(movie: movie)
            }
        }
    }
}
