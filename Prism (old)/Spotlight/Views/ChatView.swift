import SwiftUI

struct ChatView: View {
    @StateObject private var chatService: ChatService
    @State private var messageText = ""
    @FocusState private var isFocused: Bool
    @State private var selectedPrompt: String = ""
    
    init() {
        let aiService = AIService()
        _chatService = StateObject(wrappedValue: ChatService(aiService: aiService))
    }
    
    private let prompts = [
        "Portfolio Tips",
        "Networking Advice",
        "Industry Trends",
        "How to Find Gigs?",
        "Best Tools for Creators"
    ]
    
    var body: some View {
        VStack {
            // Tabs for prompts
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(prompts, id: \.self) { prompt in
                        Button(action: {
                            messageText = prompt
                        }) {
                            Text(prompt)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.purple.opacity(0.2))
                                .foregroundColor(.purple)
                                .cornerRadius(16)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            Divider()
            
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(chatService.messages) { message in
                            MessageBubble(message: message)
                        }
                    }
                    .padding()
                }
                .onChange(of: chatService.messages.count) { _ in
                    withAnimation {
                        proxy.scrollTo(chatService.messages.last?.id, anchor: .bottom)
                    }
                }
            }
            
            Divider()
            
            HStack {
                TextField("Type a message...", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($isFocused)
                
                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 24))
                }
                .disabled(messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding()
        }
        .navigationTitle("Chat with AI")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Clear") {
                    chatService.clearChat()
                }
            }
        }
    }
    
    private func sendMessage() {
        let trimmedMessage = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedMessage.isEmpty else { return }
        
        Task {
            await chatService.sendMessage(trimmedMessage)
            messageText = ""
        }
    }
}

struct MessageBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
            }
            
            Text(message.content)
                .padding()
                .background(message.isUser ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(message.isUser ? .white : .primary)
                .cornerRadius(16)
            
            if !message.isUser {
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationView {
        ChatView()
    }
}

