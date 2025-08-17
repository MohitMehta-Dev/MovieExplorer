//
//  Movie_ExplorerApp.swift
//  Movie Explorer
//
//  Created by Mohit Mehta on 18/08/25.
//

import SwiftUI

@main
struct Movie_ExplorerApp: App {
    var body: some Scene {
        WindowGroup {
            let repository: MovieRepositoryProtocol = MovieRepository(
                network: NetworkService(),
                cache: CacheService()
            )
            let viewModel = MovieListViewModel(repository: repository)
            MovieListView(viewModel: viewModel)
        }
    }
}
