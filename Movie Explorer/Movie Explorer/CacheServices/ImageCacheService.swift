//
//  ImageCacheService.swift
//  Alongside
//
//  Created by Mohit Mehta on 17/08/25.
//

import UIKit

protocol ImageCachingProtocol {
    func image(for url: URL) async -> UIImage?
    func save(_ image: UIImage, for url: URL) async
    func clearCache() async
}

actor ImageCacheService: ImageCachingProtocol {
    private let memoryCache = NSCache<NSURL, UIImage>()
    
    private var cacheDirectory: URL {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("ImageCache")
    }
    
    func image(for url: URL) -> UIImage? {
        if let image = memoryCache.object(forKey: url as NSURL) {
            return image
        }
        
        let fileURL = cacheDirectory.appendingPathComponent(url.lastPathComponent)
        if let data = try? Data(contentsOf: fileURL),
           let image = UIImage(data: data) {
            memoryCache.setObject(image, forKey: url as NSURL)
            return image
        }
        
        return nil
    }
    
    func save(_ image: UIImage, for url: URL) {
        
        memoryCache.setObject(image, forKey: url as NSURL)
        

        let fileURL = cacheDirectory.appendingPathComponent(url.lastPathComponent)
        if let data = image.pngData() {
            try? data.write(to: fileURL)
        }
    }
    
    func clearCache() async {
        memoryCache.removeAllObjects()
        try? FileManager.default.removeItem(at: cacheDirectory)
    }
}

