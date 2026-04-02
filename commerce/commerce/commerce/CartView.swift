//
//  CartView.swift
//  commerce
//
//  Created by Assistant on 4/2/2026.
//

import SwiftUI

struct CartView: View {
    @Environment(\.appState) private var app

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "cart.fill")
                .font(.system(size: 48))
            Text("Your cart is empty")
                .foregroundStyle(.secondary)
            Button("Continue Shopping") {
                app.path.removeAll()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Cart")
    }
}

#Preview {
    CartView()
        .environment(\.appState, AppState())
}
