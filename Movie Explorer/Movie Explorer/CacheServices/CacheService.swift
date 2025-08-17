//
//  CacheService.swift
//  Alongside
//
//  Created by Mohit Mehta on 17/08/25.
//

import Foundation

protocol CacheServicingProtocol {
    func save(_ movies: [Movie]) async
     func load() async -> [Movie]
     func clear() async
 }

 actor CacheService: CacheServicingProtocol {
     private var cacheURL: URL {
         let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
         return dir.appendingPathComponent("movies.json")
     }
     
     func save(_ movies: [Movie]) async {
         do {
             let data = try JSONEncoder().encode(movies)
             try data.write(to: cacheURL)
         } catch {
             print("Failed to cache movies: \(error)")
         }
     }
     
     func load() async -> [Movie] {
         do {
             let data = try Data(contentsOf: cacheURL)
             return try JSONDecoder().decode([Movie].self, from: data)
         } catch {
             return []
         }
     }
     
     func clear() async {
         try? FileManager.default.removeItem(at: cacheURL)
     }
 }
