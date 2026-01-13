import SwiftUI

// MARK: - Enough Color Palette
// Sage & Cream palette for a warm, welcoming aesthetic

extension Color {

    // MARK: - Canvas & Surface
    static let enoughCanvas = Color(hex: "FAF8F5")      // Warm cream background
    static let enoughSurface = Color(hex: "FFFFFF")     // White cards
    static let enoughSidebar = Color(hex: "F5F2EE")     // Subtle warmth for sidebar

    // MARK: - Sage (Primary)
    static let sage50 = Color(hex: "F0F5F1")
    static let sage100 = Color(hex: "DCE8DE")
    static let sage200 = Color(hex: "B8D4BC")
    static let sage400 = Color(hex: "7A9A7E")           // Primary sage
    static let sage500 = Color(hex: "5C7D60")           // Sage dark
    static let sage600 = Color(hex: "4A6550")

    // MARK: - Warm (Accent)
    static let warm100 = Color(hex: "FDF6EE")
    static let warm200 = Color(hex: "F5E6D8")
    static let warm400 = Color(hex: "C49E7A")           // Terracotta accent
    static let warm500 = Color(hex: "A67D54")

    // MARK: - Text
    static let textPrimary = Color(hex: "2C3A2E")       // Warm charcoal
    static let textSecondary = Color(hex: "5C6B5E")
    static let textTertiary = Color(hex: "8A9A8C")
    static let textMuted = Color(hex: "B8C4BA")

    // MARK: - Semantic Colors
    static let enoughPrimary = sage400
    static let enoughPrimaryDark = sage500
    static let enoughPrimaryLight = sage100
    static let enoughAccent = warm400
    static let enoughAccentLight = warm100

    // MARK: - Category Colors
    static let categoryHousing = Color(hex: "D06050")
    static let categoryGroceries = sage500
    static let categoryDining = warm500
    static let categoryShopping = Color(hex: "9333EA")
    static let categoryTransport = Color(hex: "3B82F6")
    static let categoryHealth = Color(hex: "10B981")
    static let categorySubscriptions = Color(hex: "6366F1")
    static let categoryEntertainment = Color(hex: "EC4899")
    static let categoryTravel = Color(hex: "F59E0B")
    static let categoryInsurance = Color(hex: "64748B")
    static let categoryPersonalCare = Color(hex: "A855F7")
    static let categoryGifts = Color(hex: "EF4444")
    static let categoryEducation = Color(hex: "0EA5E9")
    static let categoryUtilities = Color(hex: "84CC16")
    static let categoryOther = Color(hex: "9CA3AF")

    // MARK: - Hover & Active States
    static let hoverBackground = sage400.opacity(0.08)
    static let activeBackground = sage400.opacity(0.12)

    // MARK: - Borders
    static let borderSubtle = Color.black.opacity(0.06)
    static let borderDefault = Color.black.opacity(0.08)
}

// MARK: - Hex Color Initializer
extension Color {
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

// MARK: - Gradient Definitions
extension LinearGradient {
    static let sageGradient = LinearGradient(
        colors: [Color(hex: "9BC49E"), Color.sage400],
        startPoint: .leading,
        endPoint: .trailing
    )

    static let reviewHeroGradient = LinearGradient(
        colors: [.enoughSurface, .enoughCanvas],
        startPoint: .top,
        endPoint: .bottom
    )
}
