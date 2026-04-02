//
//  ContactSellerView.swift
//  commerce
//
//  Created by Assistant on 4/2/2026.
//

import SwiftUI

struct ContactSellerView: View {
    @State private var subject: String = ""
    @State private var body: String = ""
    
    var body: some View {
        Form {
            Section("Message") {
                TextField("Subject", text: $subject)
                TextField("Body", text: $body)
            }
            Section {
                Button("Send") {
                    // Action to send message can be implemented here
                }
                .disabled(subject.isEmpty || body.isEmpty)
            }
        }
        .navigationTitle("Contact Seller")
    }
}

#Preview {
    ContactSellerView()
}
