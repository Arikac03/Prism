import SwiftUI

extension Color {
    // Light Mode Colors
    static let lightGrey = Color(hex: "F8F6ED")
    static let darkViolet = Color(hex: "4C4F7F")
    static let darkBlue = Color(hex: "A8C7E7")
    
    // Dark Mode Colors
    static let darkGrey = Color(hex: "464643")
    static let lightViolet = Color(hex: "E8DBFF")
    static let lightBlue = Color(hex: "E6F8FE")
    
    // Secondary Colors
    static let pastelOrange = Color(hex: "F4A988")
    static let teal = Color(hex: "86D2C1")
    
    // Helper initializer for hex colors
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
