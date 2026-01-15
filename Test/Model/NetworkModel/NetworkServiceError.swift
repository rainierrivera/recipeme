//
//  NetworkServiceError.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

import Foundation

// MARK: - Network service (Real URLSession)

enum NetworkServiceError: Error {
  case invalidBaseURL(String)
  case invalidURL
  case httpError(statusCode: Int, body: Data)
  case emptyResponse
}
