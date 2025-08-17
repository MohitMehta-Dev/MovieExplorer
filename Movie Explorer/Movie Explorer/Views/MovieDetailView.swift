//
//  MovieDetailView.swift
//  Alongside
//
//  Created by Mohit Mehta on 17/08/25.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImageView(
                    url: movie.posterURL,
                    width: 60,
                    height: 90
                )
                
                Text(movie.title).font(.title).bold()
                Text("Released: \(movie.releaseYear)")
                Text(movie.overview ?? "No description available.")
                    .font(.body)
                if movie.voteAverage != nil {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(movie.formattedRating)
                            .font(.subheadline)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

