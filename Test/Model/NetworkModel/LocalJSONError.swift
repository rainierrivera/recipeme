//
//  LocalJSONError.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

enum LocalJSONError: Error {
  case fileNotFound(String)
  case decodeFailed
}

