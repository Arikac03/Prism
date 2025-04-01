import Foundation

@MainActor
class MessageBoardService: ObservableObject {
    @Published private(set) var posts: [BoardPost] = []
    
    func addPost(title: String, content: String, author: String) {
        let newPost = BoardPost(
            title: title,
            content: content,
            author: author,
            timestamp: Date(),
            likes: 0,
            comments: []
        )
        posts.insert(newPost, at: 0)
    }
    
    func addComment(to postId: UUID, content: String, author: String) {
        guard let index = posts.firstIndex(where: { $0.id == postId }) else { return }
        let comment = BoardPost.Comment(
            content: content,
            author: author,
            timestamp: Date()
        )
        posts[index].comments.append(comment)
    }
    
    func likePost(postId: UUID) {
        guard let index = posts.firstIndex(where: { $0.id == postId }) else { return }
        posts[index].likes += 1
    }
} 