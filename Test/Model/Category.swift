//
//  Category.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

enum Category: Int, Codable, CaseIterable, CustomStringConvertible {
  case meat = 1
  case vegetarian = 2
  case seafood = 3
  case dessertsAndSweets = 4
  case drinks = 5
  case salad = 6
  case pasta = 7
  case others = 999

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let rawValue = (try? container.decode(Int.self)) ?? Category.others.rawValue
    self = Category(rawValue: rawValue) ?? .others
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }

  var imageName: String {
    switch self {
    case .meat: "meat"
    case .vegetarian: "vegetarian"
    case .dessertsAndSweets: "desserts"
    case .drinks: "drinks"
    case .salad: "salad"
    case .pasta: "pasta"
    case .others: "others"
    case .seafood: "seafood"
    }
  }
  
  var description: String {
    switch self {
    case .meat: "Meat"
    case .vegetarian: "Vegetarian"
    case .dessertsAndSweets: "Desserts & Sweets"
    case .drinks: "Drinks"
    case .salad: "Salad"
    case .pasta: "Pasta & Rice"
    case .others: "Others"
    case .seafood: "Seafood"
    }
  }
}

extension Category {
  static var allDescriptions: [String] {
    Category.allCases.map { $0.description }
  }
}
