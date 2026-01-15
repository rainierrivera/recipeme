//
//  Network.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

// Set to public in case you may want to create a package from this
public protocol Network {
  
  /// All comforms to this will have to have request that will have specifc response
  func request<T: Decodable>(_ provider: NetworkProvider, responseType: T.Type) async throws -> T
}
