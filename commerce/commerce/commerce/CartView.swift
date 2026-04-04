//
//  CartView.swift
//  commerce
//
//  Created by Assistant on 4/2/2026.
//

import SwiftUI
import PassKit
import StoreKit

struct CartView: View {
    @Environment(\.appState) private var app

    @State private var isShowingAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""

    private func showPaymentAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        isShowingAlert = true
    }

    var body: some View {
        VStack(spacing: 16) {
            if app.cartItems.isEmpty {
                Image(systemName: "cart")
                    .font(.system(size: 48))
                Text("Your cart is empty")
                    .foregroundStyle(.secondary)
                Button("Continue Shopping") {
                    app.path.removeAll()
                }
                .buttonStyle(.borderedProminent)
            } else {
                List {
                    Section("Items") {
                        ForEach(app.cartItems) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.product.name)
                                    Text("$\(item.product.price, specifier: "%.2f") x \(item.quantity)")
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                Text("$\(item.lineTotal, specifier: "%.2f")")
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    app.removeFromCart(itemID: item.id)
                                } label: {
                                    Label("Remove", systemImage: "trash")
                                }
                            }
                        }
                    }
                    Section("Total") {
                        HStack {
                            Text("Subtotal")
                            Spacer()
                            Text("$\(app.cartTotal, specifier: "%.2f")")
                        }
                    }
                }
                VStack(spacing: 12) {
                    Button {
                        Task { @MainActor in
                            let total = app.cartTotal
                            PaymentManager.shared.startApplePay(total: total) { result in
                                switch result {
                                case .success:
                                    showPaymentAlert(title: "Apple Pay", message: "Payment successful. Thank you!")
                                case .failure(let error):
                                    showPaymentAlert(title: "Apple Pay", message: error.localizedDescription)
                                }
                            }
                        }
                    } label: {
                        Label("Pay with Credit Card", systemImage: "creditcard")
                    }
                    .buttonStyle(.borderedProminent)

                    Button {
                        Task {
                            let result = await PaymentManager.shared.purchaseCheckoutProduct()
                            switch result {
                            case .success:
                                await MainActor.run {
                                    showPaymentAlert(title: "In‑App Purchase", message: "Purchase successful. Thank you!")
                                }
                            case .failure(let error):
                                await MainActor.run {
                                    showPaymentAlert(title: "In‑App Purchase", message: error.localizedDescription)
                                }
                            }
                        }
                    } label: {
                        Label("Pay with In‑App Purchase", systemImage: "cart.badge.plus")
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)
            }
        }
        .padding()
        .navigationTitle("Cart")
        .alert(alertTitle, isPresented: $isShowingAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
    }
}

#Preview {
    CartView()
        .environment(\.appState, AppState())
}

