//
//  TestApp.swift
//  Test
//
//  Created by Rainier Rivera on 1/10/26.
//

import SwiftUI
import UIKit

@main
struct RecipeApp: App {
  
  @ObservedObject private var coordinator = RecipeCoordinator()
  
  var body: some Scene {
    WindowGroup {
      // Coordinator will handle the views
      coordinator.view
      .onAppear {
        coordinator.start()
      }
    }
  }
}
