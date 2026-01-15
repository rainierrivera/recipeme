//
//  AnyEncodable.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

// MARK: - AnyEncodable helper

struct AnyEncodable: Encodable {
  private let _encode: (Encoder) throws -> Void

  init(_ wrapped: any Encodable) {
    self._encode = { encoder in
      try wrapped.encode(to: encoder)
    }
  }

  func encode(to encoder: Encoder) throws {
    try _encode(encoder)
  }
}
