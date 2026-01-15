//
//  SearchItemView.swift
//  Test
//
//  Created by Rainier Rivera on 1/14/26.
//

import SwiftUI

struct SearchItemView: View {
  @StateObject var viewModel: SearchListViewModel

  init(viewModel: SearchListViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }

  var body: some View {
    List {
      if viewModel.isLoading {
        HStack {
          Spacer()
          ProgressView()
          Spacer()
        }
      }

      if let errorMessage = viewModel.errorMessage {
        Text(errorMessage)
          .foregroundStyle(.red)
      }

      ForEach(viewModel.filteredItems, id: \.self) { item in
        Button {
          viewModel.toggle(item)
        } label: {
          HStack(spacing: 12) {
            Text(item)
              .foregroundStyle(.primary)

            Spacer()

            if viewModel.isSelected(item) {
              Image(systemName: "checkmark")
                .foregroundStyle(Color.orange)
            }
          }
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
      }
    }
    .navigationTitle(viewModel.field.title)
    .navigationBarTitleDisplayMode(.inline)
    .searchable(text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always))
    .toolbar {
      ToolbarItem(placement: .cancellationAction) {
        Button("Cancel") {
          viewModel.cancel()
        }
      }

      ToolbarItem(placement: .confirmationAction) {
        Button("Done") {
          viewModel.done()
        }
      }
    }
    .task {
      viewModel.load()
    }
  }
}
