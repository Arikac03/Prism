import Foundation

struct TalentProfile: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let role: String
    let images: [String]  // Names of images in asset catalog
    let bio: String
    let location: String
    let experience: Int
    let specialties: [String]
    
    var mainImage: String {
        images.first ?? "placeholder_profile"
    }
    
    static let sampleProfiles = [
        // Models
        TalentProfile(
            name: "Sarah Johnson",
            role: "Model",
            images: ["sarah"],
            bio: "Professional fashion and runway model with experience in editorial shoots and fashion weeks.",
            location: "New York, NY",
            experience: 5,
            specialties: ["Runway", "Editorial", "Commercial"]
        ),
        TalentProfile(
            name: "James Chen",
            role: "Model",
            images: ["mike"],
            bio: "Fitness and commercial model specializing in sportswear and lifestyle photography.",
            location: "Los Angeles, CA",
            experience: 3,
            specialties: ["Fitness", "Commercial", "Lifestyle"]
        ),
        
        // Photographers
        TalentProfile(
            name: "Emily Rodriguez",
            role: "Photographer",
            images: ["emily"],
            bio: "Fashion photographer with a unique eye for editorial and high-fashion shoots.",
            location: "Miami, FL",
            experience: 7,
            specialties: ["Fashion", "Editorial", "Portrait"]
        ),
        TalentProfile(
            name: "Michael Zhang",
            role: "Photographer",
            images: ["photographer"],
            bio: "Specializing in portrait and street photography with a modern twist.",
            location: "Athens, GA",
            experience: 4,
            specialties: ["Portrait", "Street", "Event"]
        ),
        
    ]
} 
