//
//  ContentView.swift
//  Spotlight
//
//  Created by Maliyah Howell on 2/17/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @AppStorage("isLoggedIn") private var isLoggedIn = true


    
    var body: some View {
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
            
            ChatView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Chat")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(3)
        }
        .tint(.purple) // Custom accent color
    }
}

#Preview {
    ContentView()
}
