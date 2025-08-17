//
//  NetworkServicingProtocol.swift
//  Alongside
//
//  Created by Mohit Mehta on 17/08/25.
//

import Foundation

protocol NetworkServicingProtocol {
    func request<T: Decodable>(
        endpoint: APIEndpoint
    ) async throws -> T
}
