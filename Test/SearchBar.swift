//
//  SearchBar.swift
//  Test
//
//  Created by Rainier Rivera on 1/14/26.
//

import SwiftUI

// Container for search texfield
struct SearchBar: View {
  @Binding var text: String
  let placeholder: String

  var body: some View {
    AppSearchTextField(text: $text, placeholder: placeholder)
  }
}
