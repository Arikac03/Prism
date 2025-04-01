import SwiftUI

struct AuthView: View {
    @State private var isShowingLogin = true
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var selectedRole = "Model"
    @State private var isAuthenticated = false
    
    let roles = ["Model", "Photographer"]
    let gradient = LinearGradient(
        colors: [.purple.opacity(0.8), .blue.opacity(0.8)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                gradient
                    .ignoresSafeArea()
                
                // Glass morphism background
                Color.white.opacity(0.2)
                    .blur(radius: 10)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 35) {
                        // Logo and Title
                        VStack(spacing: 12) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 70))
                                .foregroundColor(.white)
                                .shadow(color: .purple.opacity(0.5), radius: 10, x: 0, y: 5)
                            
                            Text("Prism")
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                            
                            Text("Connect with creative talent")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.9))
                        }
                        .padding(.top, 50)
                        
                        // Auth Form
                        VStack(spacing: 25) {
                            if !isShowingLogin {
                                // Name Field
                                AuthTextField(
                                    text: $name,
                                    placeholder: "Full Name",
                                    systemImage: "person.fill"
                                )
                                
                                // Role Picker
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Choose your role")
                                        .foregroundColor(.white.opacity(0.8))
                                        .font(.subheadline)
                                    
                                    Picker("Role", selection: $selectedRole) {
                                        ForEach(roles, id: \.self) { role in
                                            Text(role).tag(role)
                                        }
                                    }
                                    .pickerStyle(.segmented)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(8)
                                }
                            }
                            
                            // Email Field
                            AuthTextField(
                                text: $email,
                                placeholder: "Email",
                                systemImage: "envelope.fill"
                            )
                            
                            // Password Field
                            AuthTextField(
                                text: $password,
                                placeholder: "Password",
                                systemImage: "lock.fill",
                                isSecure: true
                            )
                            
                            // Sign In/Up Button
                            Button(action: handleAuth) {
                                HStack {
                                    Image(systemName: isShowingLogin ? "arrow.right.circle.fill" : "person.fill.badge.plus")
                                    Text(isShowingLogin ? "Sign In" : "Create Account")
                                }
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(
                                    LinearGradient(
                                        colors: [.purple, .blue],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(15)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                            }
                        }
                        .padding(.horizontal, 25)
                        
                        // Toggle between Login and Sign Up
                        HStack {
                            Text(isShowingLogin ? "Don't have an account?" : "Already have an account?")
                                .foregroundColor(.white.opacity(0.9))
                            Button(isShowingLogin ? "Sign Up" : "Sign In") {
                                withAnimation(.spring(duration: 0.5)) {
                                    isShowingLogin.toggle()
                                }
                            }
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        }
                        
                        if isShowingLogin {
                            Button("Forgot Password?") {
                                // Handle forgot password
                            }
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationDestination(isPresented: $isAuthenticated) {
                ContentView()
                    .navigationBarBackButtonHidden()
            }
        }
    }
    
    private func handleAuth() {
        // TODO: Implement actual authentication
        withAnimation {
            isAuthenticated = true
        }
    }
}

// Custom TextField Style
struct AuthTextField: View {
    @Binding var text: String
    let placeholder: String
    let systemImage: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.white.opacity(0.8))
                    .font(.subheadline)
            }
            
            HStack {
                Image(systemName: systemImage)
                    .foregroundColor(.white)
                    .frame(width: 20)
                
                if isSecure {
                    SecureField(placeholder, text: $text)
                        .textContentType(isSecure ? .password : .emailAddress)
                } else {
                    TextField(placeholder, text: $text)
                        .textContentType(.emailAddress)
                }
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
        }
    }
}

// Preview
#Preview {
    AuthView()
} 
