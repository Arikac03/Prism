import SwiftUI

struct MessageBoardView: View {
    @StateObject private var boardService = MessageBoardService()
    @State private var showingNewPost = false
    @State private var searchText = ""
    
    var body: some View {
        List {
            ForEach(boardService.posts) { post in
                PostCard(post: post) { postId in
                    boardService.likePost(postId: postId)
                }
            }
        }
        .navigationTitle("Message Board")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingNewPost = true }) {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showingNewPost) {
            NewPostView(boardService: boardService)
        }
        .searchable(text: $searchText, prompt: "Search posts")
    }
}

struct PostCard: View {
    let post: BoardPost
    let onLike: (UUID) -> Void
    @State private var showingComments = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(post.title)
                .font(.headline)
            
            Text(post.content)
                .font(.body)
                .lineLimit(3)
            
            HStack {
                Text(post.author)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Button(action: { onLike(post.id) }) {
                    Label("\(post.likes)", systemImage: "heart")
                }
                
                Button(action: { showingComments.toggle() }) {
                    Label("\(post.comments.count)", systemImage: "bubble.right")
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .sheet(isPresented: $showingComments) {
            CommentsView(post: post)
        }
    }
}

struct NewPostView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var boardService: MessageBoardService
    @State private var title = ""
    @State private var content = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextEditor(text: $content)
                    .frame(height: 200)
            }
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Post") {
                        boardService.addPost(
                            title: title,
                            content: content,
                            author: "Current User" // Replace with actual user name
                        )
                        dismiss()
                    }
                    .disabled(title.isEmpty || content.isEmpty)
                }
            }
        }
    }
}

struct CommentsView: View {
    let post: BoardPost
    
    var body: some View {
        List {
            ForEach(post.comments) { comment in
                VStack(alignment: .leading, spacing: 4) {
                    Text(comment.content)
                    Text(comment.author)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Comments")
    }
} 