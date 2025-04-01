import Foundation

@MainActor
class AIService: ObservableObject {
    private let apiKey = "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"  // ⚠️ Replace with your actual API key

    private let baseURL = "https://api.openai.com/v1/chat/completions"

    @Published private(set) var isLoading = false

    private let systemPrompt = """
    You are an expert career advisor for the Spotlight app, specializing in the creative industry (modeling, acting, photography, and videography).
    
    Provide professional, actionable advice on:
    - Portfolio development
    - Industry best practices
    - Career advancement
    - Networking strategies
    - Technical skills improvement
    - Industry trends
    
    Keep responses concise, practical, and specific to the user's field. Include examples when relevant.
    """

    func getResponse(for message: String) async throws -> String {
        isLoading = true
        defer { isLoading = false }

        do {
            guard let url = URL(string: baseURL) else {
                throw URLError(.badURL)
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            let body: [String: Any] = [
                "model": "gpt-4",
                "messages": [
                    ["role": "system", "content": systemPrompt],
                    ["role": "user", "content": message]
                ],
                "temperature": 0.7,
                "max_tokens": 250
            ]

            request.httpBody = try JSONSerialization.data(withJSONObject: body)

            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(AIResponse.self, from: data)

            return response.choices.first?.message.content ?? "I'm sorry, I couldn't process that request."
        } catch {
            throw error
        }
    }
}

struct AIResponse: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let message: Message
}

struct Message: Codable {
    let content: String
}
