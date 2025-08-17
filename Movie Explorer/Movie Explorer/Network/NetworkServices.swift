//
//  NetworkService.swift
//  Alongside
//
//  Created by Mohit Mehta on 17/08/25.
//

import Foundation

final class NetworkService: NetworkServicingProtocol {
    private let session: URLSession
    private let requestTimeout: TimeInterval = 10.0
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(
        endpoint: APIEndpoint
    ) async throws -> T {
        let url = try buildURL(for: endpoint)
        let request = buildRequest(for: url)
        
        do {
            let (data, response) = try await session.data(for: request)
            try validateResponse(response)
            return try decodeData(data, as: T.self)
        } catch let error as URLError {
            throw mapURLError(error)
        } catch {
            throw error
        }
    }
    
    private func buildURL(for endpoint: APIEndpoint) throws -> URL {
        guard var components = URLComponents(string: APIConfiguration.baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }
        components.queryItems = endpoint.queryItems
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        return url
    }
    
    private func buildRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url, timeoutInterval: requestTimeout)
        APIConfiguration.authHeaders().forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }
    
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.serverError(0)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
    }
    
    private func decodeData<T: Decodable>(_ data: Data, as type: T.Type) throws -> T {
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    private func mapURLError(_ error: URLError) -> NetworkError {
        switch error.code {
        case .timedOut:
            return .timeout
        case .cancelled:
            return .cancelled
        case .notConnectedToInternet, .networkConnectionLost:
            return .networkUnavailable
        default:
            return .serverError(error.errorCode)
        }
    }
}
