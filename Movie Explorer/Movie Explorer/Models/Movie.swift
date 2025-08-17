//
//  Movie.swift
//  Alongside
//
//  Created by Mohit Mehta on 17/08/25.
//

import Foundation

struct Movie: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let releaseDate: String?
    let posterPath: String?
    let overview: String?
    let voteAverage: Double?
    
    var releaseYear: String {
        releaseDate?.prefix(4).description ?? "N/A"
    }
    
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: APIConfiguration.imageBaseURL + path)
    }
    
    var formattedRating: String {
        guard let rating = voteAverage else { return "N/A" }
        return String(format: "%.1f", rating)
    }
    
    enum CodingKeys: String, CodingKey {
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case id, title, overview
    }
}
