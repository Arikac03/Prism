import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationView {
                ChatView()
            }
            .tabItem {
                Image(systemName: "message.fill")
                Text("Chat")
            }
            
            NavigationView {
                MessageBoardView()
            }
            .tabItem {
                Image(systemName: "list.bullet.rectangle")
                Text("Board")
            }
            
            // Add other tabs here as needed
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
} 