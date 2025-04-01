import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    let categories = ["Models",  "Photographers"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Categories
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(categories, id: \.self) { category in
                                CategoryButton(title: category)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Featured Profiles
                    VStack(alignment: .leading) {
                        Text("Featured Profiles")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(TalentProfile.sampleProfiles.prefix(5)) { profile in
                                    FeaturedProfileCard(profile: profile)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Trending Projects
                    VStack(alignment: .leading) {
                        Text("Trending Projects")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(0..<5) { _ in
                                    ProjectCard()
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Explore")
            .searchable(text: $searchText, prompt: "Search talents, projects...")
        }
    }
}

struct CategoryButton: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.subheadline)
            .bold()
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(
                Capsule()
                    .fill(.purple.opacity(0.1))
            )
            .foregroundColor(.purple)
    }
}

struct FeaturedProfileCard: View {
    let profile: TalentProfile
    
    var body: some View {
        VStack {
            Image(profile.mainImage)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                Text(profile.name)
                    .font(.headline)
                Text(profile.role)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 150)
    }
}

struct ProjectCard: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray.opacity(0.2))
                .frame(width: 250, height: 150)
                .overlay(
                    Image(systemName: "camera.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .foregroundColor(.gray)
                )
            
            VStack(alignment: .leading) {
                Text("Summer Collection")
                    .font(.headline)
                Text("Fashion Photography")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
        .frame(width: 250)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

#Preview {
    ExploreView()
} 
