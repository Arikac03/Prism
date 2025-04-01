//
//  MessageView.swift
//  Spotlight
//
//  Created by Maliyah Howell on 2/17/25.
//

import SwiftUI

// Define Profile model if missing
struct Profile: Identifiable {
    var id = UUID()
    var name: String
}

struct MessageView: View {
    var matchedProfile: Profile? // Profile data passed when matched
    @State private var messageText: String = ""
    @State private var messages: [String] = ["Hey there! 👋"]

    var body: some View {
        VStack {
            // Display matched profile name
            if let profile = matchedProfile {
                Text("Chat with \(profile.name)")
                    .font(.title2)
                    .bold()
                    .padding()
            } else {
                Text("New Chat")
                    .font(.title2)
                    .padding()
            }

            // Chat messages list
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(messages, id: \.self) { message in
                        HStack {
                            Text(message)
                                .padding()
                                .background(Color.purple.opacity(0.2))
                                .cornerRadius(10)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
            }
            
            // Message input field
            HStack {
                TextField("Type a message...", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    sendMessage()
                }) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Messages")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Function to send a message
    private func sendMessage() {
        if !messageText.isEmpty {
            messages.append(messageText)
            messageText = ""
        }
    }
}

#Preview {
    MessageView(matchedProfile: Profile(name: "Alex"))
}

