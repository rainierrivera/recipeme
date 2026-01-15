//
//  CoordinatorView.swift
//  Test
//
//  Created by Rainier Rivera on 1/14/26.
//

import SwiftUI

struct CoordinatorView: View {
  
  // Navigation
  @Binding private var navPath: NavigationPath
  @Binding private var root: AnyView?
  
  // Sheet
  @Binding private var sheetIsPresented: Bool
  @Binding private var sheet: AnyView?
  
  // Full Screen
  @Binding private var fullScreenIsPresented: Bool
  @Binding private var fullScreen: AnyView?
  
  // Initializer
  init(
    navPath: Binding<NavigationPath>,
    root: Binding<AnyView?>,
    sheetIsPresented: Binding<Bool>,
    sheet: Binding<AnyView?>,
    fullScreenIsPresented: Binding<Bool>,
    fullScreen: Binding<AnyView?>
  ) {
    self._navPath = navPath
    self._root = root
    self._sheetIsPresented = sheetIsPresented
    self._sheet = sheet
    self._fullScreenIsPresented = fullScreenIsPresented
    self._fullScreen = fullScreen
  }
  
  // Body
  var body: some View {
    NavigationStack(path: $navPath) {
      (root ?? AnyView(EmptyView()))
        .navigationDestination(for: CoordinatorPath.self) { path in
          path.view
        }
    }
    .sheet(isPresented: $sheetIsPresented) {
      sheet
    }
    .fullScreenCover(isPresented: $fullScreenIsPresented) {
      fullScreen
    }
  }
}
