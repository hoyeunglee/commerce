//
//  ProductListView.swift
//  commerce
//
//  Created by Assistant on 4/2/2026.
//

import SwiftUI

struct ProductListView: View {
    @Environment(\.appState) private var app
    @State private var isShowingCartLimitAlert: Bool = false

    var body: some View {
        List {
            Section("Products") {
                ForEach(app.products) { product in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(product.name)
                            Text("$\(product.price, specifier: "%.2f")")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Button("Add to Cart") {
                            let added = app.addToCart(product: product)
                            if added {
                                app.path.append(.cart)
                            } else {
                                isShowingCartLimitAlert = true
                            }
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
        .alert("Cart Limit Reached", isPresented: $isShowingCartLimitAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("You can add up to 10 items in your cart.")
        }
    }
}

#Preview {
    ProductListView()
        .environment(\.appState, AppState())
}

