//
//  ProductListView.swift
//  commerce
//
//  Created by Assistant on 4/2/2026.
//

import SwiftUI

struct ProductListView: View {
    @Environment(\.appState) private var app

    var body: some View {
        List {
            Section("Products") {
                ForEach(1..<6) { idx in
                    HStack {
                        Text("Product #\(idx)")
                        Spacer()
                        Button("Add to Cart") {
                            app.path.append(.cart)
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
        }
        .navigationTitle("Products")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    app.path.append(.cart)
                } label: {
                    Image(systemName: "cart")
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Contact") {
                    app.path.append(.contact)
                }
            }
        }
    }
}

#Preview {
    ProductListView()
        .environment(\.appState, AppState())
}
