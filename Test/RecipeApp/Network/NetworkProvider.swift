//
//  NetworkProvider.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

import Foundation

public protocol NetworkProvider {

  var baseURL: String { get }

  var path: String { get }

  var method: NetworkMethod { get }

  var parameters: [URLQueryItem]? { get }

  var body: (any Encodable)? { get }

  var mockData: Data? { get }
}
