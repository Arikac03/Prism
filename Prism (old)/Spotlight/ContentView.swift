import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    var body: some View {
        if !isLoggedIn {
            OnboardingView()
        } else {
            TabView(selection: $selectedTab) {
            
                HomeView()
                    .tabItem {
                        Image(systemName: "person.circle.fill")
                        Text("Match")
                    }
                    .tag(0)

                ExploreView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Explore")
                    }
                    .tag(1)
                
                MessageView()
                    .tabItem {
                        Image(systemName: "message.fill")
                        Text("Chat")
                    }
                    .tag(2)

                ChatView()
                    .tabItem {
                        Image(systemName: "circle.fill")
                        Text("AI Assistant")
                    }
                    .tag(3)

                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(4)
            }
            .tint(.purple) // Custom accent color
        }
    }
}

#Preview {
    ContentView()
}

