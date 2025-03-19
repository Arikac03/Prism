import SwiftUI
import PhotosUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var currentStep = 0
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var role = "Model"
    @State private var bio = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var profileImage: Image?
    @State private var specialties: Set<String> = []
    @State private var showRoleDetails = false
    
    let roles = ["Model", "Actor", "Photographer", "Videographer"]
    let specialtiesOptions: [String: [String]] = [
        "Model": ["Fashion", "Commercial", "Runway", "Editorial", "Fitness", "Lifestyle"],
        "Actor": ["Theater", "Film", "Television", "Voice Acting", "Commercial", "Improv"],
        "Photographer": ["Portrait", "Fashion", "Wedding", "Commercial", "Street", "Event"],
        "Videographer": ["Music Videos", "Commercials", "Documentary", "Events", "Short Films", "Corporate"]
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [.purple.opacity(0.8), .blue.opacity(0.8)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // Content
                TabView(selection: $currentStep) {
                    welcomeView.tag(0)
                    signUpView.tag(1)
                    roleSelectionView.tag(2)
                    profilePhotoView.tag(3)
                    specialtiesView.tag(4)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentStep)
                
                // Navigation Buttons
                if !showRoleDetails {
                    VStack {
                        Spacer()
                        navigationButtons
                            .padding()
                    }
                }
            }
            .navigationDestination(isPresented: $showRoleDetails) {
                switch role {
                case "Model":
                    ModelDetailsView(onComplete: completeOnboarding)
                case "Actor":
                    ActorDetailsView(onComplete: completeOnboarding)
                case "Photographer", "Videographer":
                    CreatorDetailsView(role: role, onComplete: completeOnboarding)
                default:
                    EmptyView()
                }
            }
        }
    }
    
    private var welcomeView: some View {
        VStack(spacing: 25) {
            Image(systemName: "sparkles")
                .font(.system(size: 70))
                .foregroundColor(.white)
            
            Text("Welcome to Prism")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
            
            Text("Connect with creative talent and find your next collaboration")
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundColor(.white.opacity(0.9))
        }
        .padding()
    }
    
    private var signUpView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Create your account")
                .font(.title)
                .bold()
                .foregroundColor(.white)
            
            VStack(spacing: 15) {
                AuthTextField(
                    text: $name,
                    placeholder: "Full Name",
                    systemImage: "person.fill"
                )
                
                AuthTextField(
                    text: $email,
                    placeholder: "Email",
                    systemImage: "envelope.fill"
                )
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                
                AuthTextField(
                    text: $password,
                    placeholder: "Password",
                    systemImage: "lock.fill",
                    isSecure: true
                )
            }
        }
        .padding()
    }
    
    private var roleSelectionView: some View {
        VStack(spacing: 25) {
            Text("What's your creative role?")
                .font(.title)
                .bold()
                .foregroundColor(.white)
            
            Text("Choose your primary role")
                .foregroundColor(.white.opacity(0.9))
            
            VStack(spacing: 15) {
                ForEach(roles, id: \.self) { roleOption in
                    Button {
                        role = roleOption
                    } label: {
                        HStack {
                            Image(systemName: roleImage(for: roleOption))
                                .font(.title2)
                            Text(roleOption)
                                .font(.headline)
                            Spacer()
                            if role == roleOption {
                                Image(systemName: "checkmark.circle.fill")
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(role == roleOption ? .white : .white.opacity(0.2))
                        )
                        .foregroundColor(role == roleOption ? .purple : .white)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding()
    }
    
    private func roleImage(for role: String) -> String {
        switch role {
        case "Model": return "person.fill"
        case "Actor": return "theatermasks.fill"
        case "Photographer": return "camera.fill"
        case "Videographer": return "video.fill"
        default: return "person.fill"
        }
    }
    
    private var navigationButtons: some View {
        HStack {
            if currentStep > 0 {
                Button {
                    currentStep -= 1
                } label: {
                    Text("Back")
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
            
            Button {
                if currentStep == 4 {
                    showRoleDetails = true
                } else {
                    currentStep += 1
                }
            } label: {
                Text(currentStep == 4 ? "Continue" : "Next")
                    .font(.headline)
                    .foregroundColor(.purple)
                    .frame(width: 100, height: 44)
                    .background(.white)
                    .cornerRadius(10)
            }
            .disabled(currentStep == 1 && (name.isEmpty || email.isEmpty || password.isEmpty))
        }
        .padding(.horizontal)
    }
    
    private func completeOnboarding() {
        // Save user data here
        hasCompletedOnboarding = true
        isLoggedIn = true // Automatically log them in after completing onboarding
    }
    
    private var profilePhotoView: some View {
        VStack(spacing: 25) {
            Text("Add your profile photo")
                .font(.title)
                .bold()
                .foregroundColor(.white)
            
            ZStack {
                if let profileImage {
                    profileImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                } else {
                    Circle()
                        .fill(.white.opacity(0.2))
                        .frame(width: 200, height: 200)
                        .overlay(
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .foregroundColor(.white)
                        )
                }
                
                PhotosPicker(selection: $selectedItem) {
                    Circle()
                        .fill(.black.opacity(0.4))
                        .frame(width: 200, height: 200)
                        .overlay(
                            Image(systemName: "camera.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                        )
                        .opacity(0.7)
                }
            }
            
            Text("Choose a photo that clearly shows your face")
                .foregroundColor(.white.opacity(0.9))
        }
        .padding()
        .onChange(of: selectedItem) { oldValue, newValue in
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    profileImage = Image(uiImage: uiImage)
                }
            }
        }
    }
    
    private var specialtiesView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Select your specialties")
                .font(.title)
                .bold()
                .foregroundColor(.white)
            
            Text("Choose up to 5 areas you specialize in")
                .foregroundColor(.white.opacity(0.9))
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(specialtiesOptions[role] ?? [], id: \.self) { specialty in
                        SpecialtyButton(
                            title: specialty,
                            isSelected: specialties.contains(specialty),
                            action: {
                                if specialties.contains(specialty) {
                                    specialties.remove(specialty)
                                } else if specialties.count < 5 {
                                    specialties.insert(specialty)
                                }
                            }
                        )
                    }
                }
            }
            
            if !specialties.isEmpty {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Selected Specialties:")
                        .foregroundColor(.white.opacity(0.9))
                    
                    FlowLayouts(spacing: 8) {
                        ForEach(Array(specialties), id: \.self) { specialty in
                            Text(specialty)
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .fill(.white)
                                )
                                .foregroundColor(.purple)
                        }
                    }
                }
                .padding(.top)
            }
        }
        .padding()
    }
}

struct SpecialtyButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isSelected ? .white : .white.opacity(0.2))
                )
                .foregroundColor(isSelected ? .purple : .white)
        }
    }
}

struct FlowLayouts: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        
        var width: CGFloat = 0
        var height: CGFloat = 0
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        for size in sizes {
            if x + size.width > proposal.width ?? 0 {
                x = 0
                y += size.height + spacing
            }
            
            x += size.width + spacing
            width = max(width, x)
            height = max(height, y + size.height)
        }
        
        return CGSize(width: width, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        
        var x = bounds.minX
        var y = bounds.minY
        
        for (index, size) in sizes.enumerated() {
            if x + size.width > bounds.maxX {
                x = bounds.minX
                y += size.height + spacing
            }
            
            subviews[index].place(
                at: CGPoint(x: x, y: y),
                proposal: ProposedViewSize(size)
            )
            
            x += size.width + spacing
        }
    }
}

#Preview {
    OnboardingView()
} 
