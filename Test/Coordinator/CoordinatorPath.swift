//
//  MainCoordinator.swift
//  Test
//
//  Created by Rainier Rivera on 1/14/26.
//

import SwiftUI

struct CoordinatorPath: Hashable {
  
  let id: UUID
  let view: AnyView
  
  init<V: View>(view: V) {
    self.id = UUID()
    self.view = AnyView(view)
  }
  
  static func == (lhs: CoordinatorPath, rhs: CoordinatorPath) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
