//
//  Coordinator.swift
//  Test
//
//  Created by Rainier Rivera on 1/14/26.
//

import SwiftUI
import Combine

class Coordinator: ObservableObject {
  
  // Navigation
  @Published private var navPath: NavigationPath
  @Published private var root: AnyView?
  
  // Sheet
  @Published private var sheetIsPresented: Bool
  @Published private var sheet: AnyView?
  
  // Full Screen
  @Published private var fullScreenIsPresented: Bool
  @Published private var fullScreen: AnyView?
  
  // View
  var view: some View {
    CoordinatorView(
      navPath: Binding(
        get: { [weak self] in self?.navPath ?? NavigationPath() },
        set: { [weak self] in self?.navPath = $0 }
      ),
      root: Binding(
        get: { [weak self] in self?.root },
        set: { [weak self] in self?.root = $0 }
      ),
      sheetIsPresented: Binding(
        get: { [weak self] in self?.sheetIsPresented ?? false },
        set: { [weak self] in self?.sheetIsPresented = $0 }
      ),
      sheet: Binding(
        get: { [weak self] in self?.sheet },
        set: { [weak self] in self?.sheet = $0 }
      ),
      fullScreenIsPresented: Binding(
        get: { [weak self] in self?.fullScreenIsPresented ?? false },
        set: { [weak self] in self?.fullScreenIsPresented = $0 }
      ),
      fullScreen: Binding(
        get: { [weak self] in self?.fullScreen },
        set: { [weak self] in self?.fullScreen = $0 }
      )
    )
  }
  
  // Initializer
  init() {
    
    // States
    navPath = NavigationPath()
    root = nil
    sheetIsPresented = false
    sheet = nil
    fullScreenIsPresented = false
    fullScreen = nil
  }
  
  func root<V: View>(view: V) {
    navPath = NavigationPath()
    root = AnyView(view)
    sheetIsPresented = false
    sheet = nil
    fullScreenIsPresented = false
    fullScreen = nil
  }
  
  func push<V: View>(view: V) {
    guard root != nil else { return }
    guard !sheetIsPresented && !fullScreenIsPresented else { return }
    navPath.append(CoordinatorPath(view: view))
  }
  
  func pop() {
    guard root != nil else { return }
    guard !sheetIsPresented && !fullScreenIsPresented else { return }
    guard !navPath.isEmpty else { return }
    navPath.removeLast()
  }
  
  func popToRoot() {
    guard root != nil else { return }
    guard !sheetIsPresented && !fullScreenIsPresented else { return }
    guard !navPath.isEmpty else { return }
    navPath.removeLast(navPath.count)
  }
  
  func presentSheet<V: View>(view: V) {
    guard root != nil else { return }
    guard !sheetIsPresented && !fullScreenIsPresented else { return }
    sheet = AnyView(view)
    sheetIsPresented = true
  }
  
  func presentFullScreen<V: View>(view: V) {
    guard root != nil else { return }
    guard !sheetIsPresented && !fullScreenIsPresented else { return }
    fullScreen = AnyView(view)
    fullScreenIsPresented = true
  }
}
