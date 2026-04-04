//
//  ContactSellerView.swift
//  commerce
//
//  Created by Assistant on 4/2/2026.
//

import SwiftUI

struct ContactSellerView: View {
    @State private var subject: String = ""
    @State private var messageBody: String = ""
    
    var body: some View {
        Form {
            Section("Message") {
                TextField("Subject", text: $subject)
                TextField("Body", text: $messageBody)
            }
            Section {
                Button("Send") {
                    // Action to send message can be implemented here
                }
                .disabled(subject.isEmpty || messageBody.isEmpty)
            }
        }
        .navigationTitle("Contact Seller")
    }
}

#Preview {
    ContactSellerView()
}
