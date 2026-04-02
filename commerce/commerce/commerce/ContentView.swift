//
//  ContentView.swift
//  commerce
//
//  Created by Ho Yeung, Lee on 1/4/2026.
//

import SwiftUI
import Observation

struct ContentView: View {
    @State private var app = AppState()

    var body: some View {
        Group {
            if app.isAuthenticated {
                NavigationStack(path: $app.path) {
                    ProductListView()
                        .navigationDestination(for: AppState.Route.self) { route in
                            switch route {
                            case .productList:
                                ProductListView()
                            case .cart:
                                CartView()
                            case .contact:
                                ContactSellerView()
                            }
                        }
                }
            } else {
                LoginView()
            }
        }
        .environment(\.appState, app)
    }
}

#Preview {
    ContentView()
}
