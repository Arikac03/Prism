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
            images: ["actor1","istockphoto-1411160666-612x612.jpg"],
            bio: "Professional fashion and runway model with experience in editorial shoots and fashion weeks.",
            location: "New York, NY",
            experience: 5,
            specialties: ["Runway", "Editorial", "Commercial"]
        ),
        TalentProfile(
            name: "James Chen",
            role: "Model",
            images: ["model2", "model2_2", "model2_3"],
            bio: "Fitness and commercial model specializing in sportswear and lifestyle photography.",
            location: "Los Angeles, CA",
            experience: 3,
            specialties: ["Fitness", "Commercial", "Lifestyle"]
        ),
        
        // Photographers
        TalentProfile(
            name: "Emily Rodriguez",
            role: "Photographer",
            images: ["photographer1", "photographer1_2"],
            bio: "Fashion photographer with a unique eye for editorial and high-fashion shoots.",
            location: "Miami, FL",
            experience: 7,
            specialties: ["Fashion", "Editorial", "Portrait"]
        ),
        TalentProfile(
            name: "Michael Zhang",
            role: "Photographer",
            images: ["photographer2", "photographer2_2"],
            bio: "Specializing in portrait and street photography with a modern twist.",
            location: "San Francisco, CA",
            experience: 4,
            specialties: ["Portrait", "Street", "Event"]
        ),
        
        // Actors
        TalentProfile(
            name: "David Williams",
            role: "Actor",
            images: ["actor1", "actor1_2", "actor1_3"],
            bio: "Theater-trained actor with experience in commercials and independent films.",
            location: "Chicago, IL",
            experience: 6,
            specialties: ["Theater", "Film", "Commercial"]
        ),
        TalentProfile(
            name: "Sofia Patel",
            role: "Actor",
            images: ["actor2", "actor2_2"],
            bio: "Versatile actor specializing in dramatic roles and voice acting.",
            location: "Atlanta, GA",
            experience: 4,
            specialties: ["Drama", "Voice Acting", "Television"]
        ),
        
        // Videographers
        TalentProfile(
            name: "Alex Thompson",
            role: "Videographer",
            images: ["videographer1", "videographer1_2"],
            bio: "Creative videographer specializing in music videos and short films.",
            location: "Nashville, TN",
            experience: 5,
            specialties: ["Music Videos", "Short Films", "Commercial"]
        ),
        TalentProfile(
            name: "Maria Garcia",
            role: "Videographer",
            images: ["videographer2", "videographer2_2"],
            bio: "Documentary and event videographer with a journalistic approach.",
            location: "Boston, MA",
            experience: 8,
            specialties: ["Documentary", "Events", "Corporate"]
        )
    ]
} 
