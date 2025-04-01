import Foundation

@MainActor
class ChatService: ObservableObject {
    @Published private(set) var messages: [ChatMessage] = []
    private let aiService: AIService
    
    init(aiService: AIService) {
        self.aiService = aiService
    }
    
    func sendMessage(_ content: String) async {
        // Add user message
        let userMessage = ChatMessage(content: content, isUser: true)
        messages.append(userMessage)
        
        do {
            // Simulate AI response for now
            try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
            let aiMessage = ChatMessage(
                content: "This is a simulated AI response to: \(content)",
                isUser: false
            )
            messages.append(aiMessage)
        } catch {
            let errorMessage = ChatMessage(
                content: "Sorry, I encountered an error. Please try again.",
                isUser: false
            )
            messages.append(errorMessage)
        }
    }
    
    func clearChat() {
        messages.removeAll()
    }
} 