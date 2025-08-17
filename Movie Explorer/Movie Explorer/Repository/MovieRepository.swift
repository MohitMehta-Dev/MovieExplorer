//
//  MovieRepository.swift
//  Alongside
//
//  Created by Mohit Mehta on 17/08/25.
//

import Foundation

protocol MovieRepositoryProtocol {
    func fetchPopularMovies() async throws -> [Movie]
    func loadCachedMovies() async -> [Movie]
    func clearCache() async
    
}

final class MovieRepository: MovieRepositoryProtocol {
    private let network: NetworkServicingProtocol
    private let cache: CacheServicingProtocol
    
    init(network: NetworkServicingProtocol, cache: CacheServicingProtocol) {
        self.network = network
        self.cache = cache
    }
    
    func fetchPopularMovies() async throws -> [Movie] {
        struct Response: Codable { let results: [Movie] }
        
        let result: Response = try await network.request(endpoint: .popularMovies)
        
        await cache.save(result.results)
        return result.results
    }
    
    func loadCachedMovies() async-> [Movie] {
        await cache.load()
    }
    
    func clearCache() async {
        await cache.clear()
    }
    
}
