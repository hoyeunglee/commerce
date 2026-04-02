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

    var isAuthenticated: Bool = false
    var path: [Route] = []
}
