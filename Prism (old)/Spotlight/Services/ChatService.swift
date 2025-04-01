import Foundation

struct ChatMessage: Identifiable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date
}

@MainActor
class ChatService: ObservableObject {
    @Published private(set) var messages: [ChatMessage] = []
    private let aiService: AIService
    
    init(aiService: AIService) {
        self.aiService = aiService
    }
    
    func sendMessage(_ content: String) async {
        // Add user message
        let userMessage = ChatMessage(content: content, isUser: true, timestamp: Date())
        messages.append(userMessage)
        
        do {
            // Get AI response
            let response = try await aiService.getResponse(for: content)
            let aiMessage = ChatMessage(content: response, isUser: false, timestamp: Date())
            messages.append(aiMessage)
        } catch {
            // Handle error by adding an error message
            let errorMessage = ChatMessage(
                content: "Sorry, I encountered an error. Please try again.",
                isUser: false,
                timestamp: Date()
            )
            messages.append(errorMessage)
        }
    }
    
    func clearChat() {
        messages.removeAll()
    }
} 