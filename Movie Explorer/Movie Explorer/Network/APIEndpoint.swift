//
//  APIEndpoint.swift
//  Alongside
//
//  Created by Mohit Mehta on 17/08/25.
//

import Foundation

enum APIEndpoint {
    case popularMovies
    case topRatedMovies
    case nowPlayingMovies
    
    var path: String {
        switch self {
        case .popularMovies:
            return "/movie/popular"
        case .topRatedMovies:
            return "/movie/top_rated"
        case .nowPlayingMovies:
            return "/movie/now_playing"
        }
    }
    
    var queryItems: [URLQueryItem] {
        let items = [URLQueryItem(name: "api_key", value: APIConfiguration.apiKeyParameter().replacingOccurrences(of: "api_key=", with: ""))]
        
        return items
    }
}
