//
//  MovieRowView.swift
//  Alongside
//
//  Created by Mohit Mehta on 17/08/25.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            AsyncImageView(
                url: movie.posterURL,
                width: 60,
                height: 90
            )
            
            VStack(alignment: .leading) {
                Text(movie.title).font(.headline)
                Text(movie.releaseYear).font(.subheadline).foregroundColor(.secondary)
            }
        }
    }
}
