//
//  APIConfiguration.swift
//  Alongside
//
//  Created by Mohit Mehta on 17/08/25.
//

import Foundation

struct APIConfiguration {
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    private static let apiKey = "06840463d3d25f8933cf00a9753e9ae1"
    private static let bearerToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNjg0MDQ2M2QzZDI1Zjg5MzNjZjAwYTk3NTNlOWFlMSIsIm5iZiI6MTc0ODM4MzY5MC41MTIsInN1YiI6IjY4MzYzN2NhMzUzNzAxMmEyMjQxNGIxNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kkRerUQGG_5tolyX-hK0p_c0nLNZYqbXosVrbF3LOa0"
    
    static func authHeaders() -> [String: String] {
        return ["Authorization": "Bearer \(bearerToken)"]
    }
    
    static func apiKeyParameter() -> String {
        return "api_key=\(apiKey)"
    }
}
