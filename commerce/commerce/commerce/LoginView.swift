//
//  LoginView.swift
//  commerce
//
//  Created by Assistant on 4/2/2026.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.appState) private var app
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack(spacing: 16) {
            Text("Welcome")
                .font(.largeTitle)
                .bold()
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            Button("Sign In") {
                // Minimal behavior: mark authenticated
                app.isAuthenticated = true
            }
            .buttonStyle(.borderedProminent)
            .disabled(email.isEmpty || password.isEmpty)
        }
        .padding()
    }
}

#Preview {
    LoginView()
        .environment(\.appState, AppState())
}
