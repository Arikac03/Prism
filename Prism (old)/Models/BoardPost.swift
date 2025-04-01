import Foundation

struct BoardPost: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    let author: String
    let timestamp: Date
    var likes: Int
    var comments: [Comment]
    
    struct Comment: Identifiable {
        let id = UUID()
        let content: String
        let author: String
        let timestamp: Date
    }
} 