import SwiftUI
import PhotosUI

struct ProfileView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = true
    @State private var selectedItem: PhotosPickerItem?
    @State private var profileImage: Image?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Header
                    VStack(spacing: 15) {
                        ZStack {
                            if let profileImage {
                                profileImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                            } else {
                                Circle()
                                    .fill(.gray.opacity(0.2))
                                    .frame(width: 120, height: 120)
                                    .overlay(
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60)
                                            .foregroundColor(.gray)
                                    )
                            }
                            
                            PhotosPicker(selection: $selectedItem) {
                                Circle()
                                    .fill(.black.opacity(0.3))
                                    .frame(width: 120, height: 120)
                                    .overlay(
                                        Image(systemName: "camera.fill")
                                            .foregroundColor(.white)
                                    )
                                    .opacity(0.7)
                            }
                        }
                        
                        Text("Your Name")
                            .font(.title2)
                            .bold()
                        
                        Text("Model")
                            .foregroundColor(.gray)
                    }
                    
                    // Stats
                    HStack(spacing: 40) {
                        VStack {
                            Text("128")
                                .font(.title3)
                                .bold()
                            Text("Matches")
                                .foregroundColor(.gray)
                        }
                        
                        VStack {
                            Text("45")
                                .font(.title3)
                                .bold()
                            Text("Projects")
                                .foregroundColor(.gray)
                        }
                        
                        VStack {
                            Text("892")
                                .font(.title3)
                                .bold()
                            Text("Views")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical)
                    
                    // Settings
                    VStack(spacing: 0) {
                        SettingsRow(title: "Edit Profile", icon: "person.fill")
                        SettingsRow(title: "Notifications", icon: "bell.fill")
                        SettingsRow(title: "Privacy", icon: "lock.fill")
                        SettingsRow(title: "Help & Support", icon: "questionmark.circle.fill")
                        
                        Button {
                            isLoggedIn = false
                        } label: {
                            SettingsRow(title: "Sign Out", icon: "arrow.right.circle.fill", isDestructive: true)
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.05), radius: 5)
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SettingsRow: View {
    let title: String
    let icon: String
    var isDestructive: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 24)
                .foregroundColor(isDestructive ? .red : .purple)
            
            Text(title)
                .foregroundColor(isDestructive ? .red : .primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
    }
}

#Preview {
    ProfileView()
} 