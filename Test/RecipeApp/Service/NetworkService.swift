//
//  NetworkService.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

import Foundation

final class NetworkService: Network {
  private let session: URLSession
  private let defaultHeaders: [String: String]
  private let encoder: JSONEncoder
  private let decoder: JSONDecoder

  init(
    session: URLSession = .shared,
    defaultHeaders: [String: String] = [
      "Content-Type": "application/json"
    ],
    encoder: JSONEncoder = JSONEncoder(),
    decoder: JSONDecoder = JSONDecoder()
  ) {
    self.session = session
    self.defaultHeaders = defaultHeaders
    self.encoder = encoder
    self.decoder = decoder
  }

  func request<T: Decodable>(_ provider: NetworkProvider,
                             responseType: T.Type) async throws -> T {
    let urlRequest = try buildURLRequest(from: provider)

    let (data, response) = try await session.data(for: urlRequest)

    guard let http = response as? HTTPURLResponse else {
      throw NetworkServiceError.emptyResponse
    }

    guard (200...299).contains(http.statusCode) else {
      throw NetworkServiceError.httpError(statusCode: http.statusCode, body: data)
    }

    // Some endpoints may return empty body (204). If the caller expects Decodable,
    // surface a clear error.
    guard !data.isEmpty else {
      throw NetworkServiceError.emptyResponse
    }

    return try decoder.decode(T.self, from: data)
  }

  private func buildURLRequest(from provider: NetworkProvider) throws -> URLRequest {
    guard var components = URLComponents(string: provider.baseURL) else {
      throw NetworkServiceError.invalidBaseURL(provider.baseURL)
    }

    // Ensure path appends correctly.
    let basePath = components.path
    if provider.path.hasPrefix("/") {
      components.path = basePath + provider.path
    } else {
      components.path = basePath + "/" + provider.path
    }

    if let params = provider.parameters, !params.isEmpty {
      components.queryItems = params
    }

    guard let url = components.url else {
      throw NetworkServiceError.invalidURL
    }

    var request = URLRequest(url: url)
    request.httpMethod = provider.method.rawValue.uppercased()

    // Apply default headers
    for (k, v) in defaultHeaders {
      request.setValue(v, forHTTPHeaderField: k)
    }

    // Allow endpoint-specific mockData usage in higher layers; NetworkService ignores it.

    // Encode body if provided
    if let body = provider.body {
      request.httpBody = try encoder.encode(AnyEncodable(body))
    }

    return request
  }
}
