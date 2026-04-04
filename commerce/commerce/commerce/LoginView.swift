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
    @State private var errorMessage: String? = nil
    private let demoEmail: String = "demo@commerce.app"
    private let demoPassword: String = "demo1234"

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
            if let errorMessage {
                Text(errorMessage)
                    .font(.footnote)
                    .foregroundStyle(.red)
            }
            Button("Sign In") {
                let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                if trimmedEmail == demoEmail && password == demoPassword {
                    errorMessage = nil
                    app.isAuthenticated = true
                } else {
                    errorMessage = "Invalid email or password. Use the demo credentials below."
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(email.isEmpty || password.isEmpty)
            Button("Use Demo Credentials") {
                email = demoEmail
                password = demoPassword
                errorMessage = nil
            }
            .buttonStyle(.bordered)
            Text("Demo: \(demoEmail) / \(demoPassword)")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview {
    LoginView()
        .environment(\.appState, AppState())
}
