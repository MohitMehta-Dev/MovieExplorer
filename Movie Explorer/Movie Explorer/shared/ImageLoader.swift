//
//  ImageLoader.swift
//  Alongside
//
//  Created by Mohit Mehta on 17/08/25.
//

import UIKit


@MainActor
final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false
    @Published var error: Error?
    
    private let cache: ImageCachingProtocol
    private let url: URL?
    private var currentTask: Task<Void, Never>?
    
    init(url: URL?, cache: ImageCachingProtocol) {
        self.url = url
        self.cache = cache
    }
    
    deinit {
        currentTask?.cancel()
        currentTask = nil
    }
    
    func load() {
        guard let url = url else { return }
        
        Task {
            if let cached = await cache.image(for: url) {
                image = cached
                return
            }
        }
        
        cancel()
        
        isLoading = true
        error = nil
        
        currentTask = Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                guard !Task.isCancelled else { return }
                
                if let img = UIImage(data: data) {
                    await cache.save(img, for: url)
                    
                    await MainActor.run {
                        self.image = img
                        self.isLoading = false
                    }
                } else {
                    await MainActor.run {
                        self.error = NetworkError.decodingError(URLError(.badServerResponse))
                        self.isLoading = false
                    }
                }
            } catch {
                guard !Task.isCancelled else { return }
                
                await MainActor.run {
                    self.error = error
                    self.isLoading = false
                }
            }
        }
    }
    
    func cancel() {
        currentTask?.cancel()
        currentTask = nil
        isLoading = false
    }
}
