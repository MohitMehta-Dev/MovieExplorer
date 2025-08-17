//
//  MovieListViewModel.swift
//  Alongside
//
//  Created by Mohit Mehta on 17/08/25.
//

import Foundation

@MainActor
final class MovieListViewModel: ObservableObject {
    var moviesData: [Movie] = []
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchedText: String = ""
    
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchMovies() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let freshMovies = try await repository.fetchPopularMovies()
            moviesData = freshMovies
            movies = moviesData
        } catch {
            errorMessage = "Failed to load movies. Showing cached data."
            moviesData = await repository.loadCachedMovies()
            moviesData = movies
        }
    }
    
    func getSearchResults(){
        guard !searchedText.isEmpty && searchedText.count >= 3  else { return movies = moviesData }
        movies = moviesData.filter { movie in
            movie.title.lowercased().contains(searchedText.lowercased())
        }
    }
}

