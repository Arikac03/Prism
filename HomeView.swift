import SwiftUI

struct HomeView: View {
    @State private var profiles: [TalentProfile]
    @State private var currentIndex = 0
    @State private var showMatchAlert = false
    @State private var matchedProfile: TalentProfile?
    
    init() {
        // Initialize with sample profiles
        _profiles = State(initialValue: TalentProfile.sampleProfiles.shuffled())
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                if profiles.isEmpty {
                    ContentUnavailableView(
                        "No More Profiles",
                        systemImage: "person.2",
                        description: Text("Check back later for new talent matches")
                    )
                } else {
                    VStack(spacing: 0) {
                        // Card Stack
                        ZStack {
                            ForEach(profiles.prefix(3).reversed()) { profile in
                                ProfileCard(profile: profile) { isLiked in
                                    handleSwipe(isLiked: isLiked, profile: profile)
                                }
                                .stacked(at: profiles.firstIndex(of: profile) ?? 0, in: profiles.count)
                            }
                        }
                        .frame(height: 480)
                        .padding(.top)
                        
                        // Action Buttons
                        HStack(spacing: 24) {
                            ActionButton(
                                action: { handleSwipe(isLiked: false, profile: profiles[0]) },
                                icon: "xmark",
                                color: .red
                            )
                            
                            ActionButton(
                                action: { handleSwipe(isLiked: true, profile: profiles[0]) },
                                icon:"hand.thumbsup.fill",
                                color: .green
                            )
                        }
                        .padding(.vertical)
                        
                        // Profile Info Section
                        if let currentProfile = profiles.first {
                            VStack(spacing: 16) {
                                // Name and Role
                                HStack(spacing: 8) {
                                    Text(currentProfile.name)
                                        .font(.title2)
                                        .bold()
                                    Text("•")
                                        .foregroundColor(.gray)
                                    Text(currentProfile.role)
                                        .foregroundColor(.gray)
                                }
                                
                                // Location and Experience
                                HStack {
                                    Image(systemName: "location.fill")
                                        .foregroundColor(.gray)
                                    Text(currentProfile.location)
                                        .foregroundColor(.gray)
                                    Text("•")
                                        .foregroundColor(.gray)
                                    Text("\(currentProfile.experience) years")
                                        .foregroundColor(.gray)
                                }
                                .font(.subheadline)
                                
                                // Specialties
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 8) {
                                        ForEach(currentProfile.specialties, id: \.self) { specialty in
                                            Text(specialty)
                                                .font(.caption)
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 6)
                                                .background(
                                                    Capsule()
                                                        .fill(.purple.opacity(0.1))
                                                )
                                                .foregroundColor(.purple)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .padding()
                            .background(Color.white)
                        }
                        
                        Spacer(minLength: 0)
                    }
                }
            }
            .navigationTitle("Discover")
            .navigationBarTitleDisplayMode(.inline)
            .alert("It's a Match! 🎉", isPresented: $showMatchAlert) {
                Button("Message", role: .none) {
                    // TODO: Navigate to chat
                }
                Button("Continue Browsing", role: .cancel) {}
            } message: {
                if let matchedProfile = matchedProfile {
                    Text("You and \(matchedProfile.name) liked each other!")
                }
            }
        }
    }
    
    private func handleSwipe(isLiked: Bool, profile: TalentProfile) {
        if isLiked {
            if Double.random(in: 0...1) < 0.3 {
                matchedProfile = profile
                showMatchAlert = true
            }
        }
        
        // Remove the current profile
        if let index = profiles.firstIndex(of: profile) {
            withAnimation(.easeOut) {
                _ = profiles.remove(at: index)
            }
        }
    }
}

struct ProfileCard: View {
    let profile: TalentProfile
    @State private var offset = CGSize.zero
    @State private var currentImageIndex = 0
    var onSwipe: (Bool) -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(radius: 8)
            
            VStack(spacing: 0) {
                // Image Gallery
                TabView(selection: $currentImageIndex) {
                    ForEach(profile.images.indices, id: \.self) { index in
                        ZStack(alignment: .topTrailing) {
                            Image(profile.images[index])
                                .resizable()
                                .scaledToFill()
                            
                            // Image Counter
                            Text("\(index + 1)/\(profile.images.count)")
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(.black.opacity(0.6))
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                                .padding(8)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 480)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .frame(width: 320, height: 480)
        .offset(offset)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { gesture in
                    let swipeThreshold: CGFloat = 150
                    if abs(gesture.translation.width) > swipeThreshold {
                        let isLiked = gesture.translation.width > 0
                        withAnimation {
                            offset.width = gesture.translation.width > 0 ? 500 : -500
                        }
                        onSwipe(isLiked)
                    } else {
                        withAnimation {
                            offset = .zero
                        }
                    }
                }
        )
    }
}

struct ActionButton: View {
    let action: () -> Void
    let icon: String
    let color: Color
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(color)
                .frame(width: 64, height: 64)
                .background(
                    Circle()
                        .fill(.white)
                        .shadow(radius: 8)
                )
        }
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self
            .offset(y: -offset * 8)
            .scaleEffect(1 - CGFloat(position) * 0.05)
    }
}

#Preview {
    HomeView()
} 
