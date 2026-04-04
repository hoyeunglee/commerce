//
//  AppState.swift
//  commerce
//
//  Created by Assistant on 4/2/2026.
//

import Foundation
import Observation

@Observable
final class AppState {
    enum Route: Hashable {
        case productList
        case cart
        case contact
    }

    // Demo catalog
    let products: [Product] = (1...5).map { idx in
        Product(id: idx, name: "Product #\(idx)", price: Double(idx) * 9.99)
    }

    // Simple cart line item
    struct CartItem: Identifiable, Hashable {
        let id = UUID()
        let product: Product
        var quantity: Int
        var lineTotal: Double { Double(quantity) * product.price }
    }

    // Cart state
    var cartItems: [CartItem] = []

    // Cart limits
    let maxCartQuantity: Int = 10
    var currentCartQuantity: Int { cartItems.reduce(0) { $0 + $1.quantity } }

    // Cart helpers
    func addToCart(product: Product) -> Bool {
        if currentCartQuantity >= maxCartQuantity {
            return false
        }
        if let idx = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[idx].quantity += 1
        } else {
            cartItems.append(CartItem(product: product, quantity: 1))
        }
        return true
    }

    func removeFromCart(itemID: UUID) {
        cartItems.removeAll { $0.id == itemID }
    }

    var cartTotal: Double {
        cartItems.reduce(0) { $0 + $1.lineTotal }
    }

    var isAuthenticated: Bool = false
    var path: [Route] = []
}
