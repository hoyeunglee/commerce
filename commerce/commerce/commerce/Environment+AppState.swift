//
//  Environment+AppState.swift
//  commerce
//
//  Created by Assistant on 4/2/2026.
//

import SwiftUI

private struct AppStateKey: EnvironmentKey {
    static let defaultValue: AppState = AppState()
}

extension EnvironmentValues {
    var appState: AppState {
        get { self[AppStateKey.self] }
        set { self[AppStateKey.self] = newValue }
    }
}
