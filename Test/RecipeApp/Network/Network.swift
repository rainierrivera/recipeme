//
//  Network.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

protocol Network {
  func request<T: Decodable>(_ provider: NetworkProvider, responseType: T.Type) async throws -> T
}
