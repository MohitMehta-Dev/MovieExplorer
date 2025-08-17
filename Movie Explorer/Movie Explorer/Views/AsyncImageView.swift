//
//  AsyncImageView.swift
//  Alongside
//
//  Created by Mohit Mehta on 17/08/25.
//

import SwiftUI

struct AsyncImageView: View {
    let url: URL?
    let width: CGFloat
    let height: CGFloat
    
    @StateObject private var loader: ImageLoader
    
    init(url: URL?, width: CGFloat, height: CGFloat, cache: ImageCachingProtocol = ImageCacheService()) {
        self.url = url
        self.width = width
        self.height = height
        _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: cache))
    }
    
    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else if loader.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray.opacity(0.3))
            } else {
                Color.gray.opacity(0.3)
            }
        }
        .frame(width: width, height: height)
        .cornerRadius(8)
        .onAppear {
            loader.load()
        }
        .onDisappear {
            loader.cancel()
        }
    }
}
