import SwiftUI

// MARK: - Enough Typography System
// Source Serif 4 for display, SF Pro for UI, SF Mono for amounts

extension Font {

    // MARK: - Display Fonts (Source Serif 4)
    // Used for large numbers and headings - adds warmth and sophistication

    /// Helper to create Source Serif 4 font with fallback to Georgia
    private static func sourceSerif(size: CGFloat, weight: Font.Weight = .light) -> Font {
        // Try the PostScript name first, then family name with weight
        // The font should be registered via Info.plist ATSApplicationFontsPath
        let fontName: String
        switch weight {
        case .light:
            fontName = "SourceSerif4-Light"
        case .regular:
            fontName = "SourceSerif4-Regular"
        case .medium:
            fontName = "SourceSerif4-Medium"
        default:
            fontName = "SourceSerif4-Regular"
        }
        return Font.custom(fontName, size: size)
    }

    /// 64px - Primary enough number display (main amount)
    static let displayLarge = sourceSerif(size: 64, weight: .light)

    /// 36px - Secondary display text
    static let displayMedium = sourceSerif(size: 36, weight: .light)

    /// 40px - Page titles (month headers)
    static let displayTitle = sourceSerif(size: 40, weight: .light)

    /// 28px - Card amounts
    static let displayAmount = sourceSerif(size: 28, weight: .light)

    /// 26px - Category amounts
    static let displayCategory = sourceSerif(size: 26, weight: .light)

    /// 24px - Review merchant names, target amounts
    static let displaySmall = sourceSerif(size: 24, weight: .light)

    /// 22px - Sidebar enough badge
    static let displayBadge = sourceSerif(size: 22, weight: .light)

    // MARK: - Heading Fonts (SF Pro)
    // Used for section headers and emphasis

    /// 20px semibold
    static let headingLarge = Font.system(size: 20, weight: .semibold)

    /// 15px semibold
    static let headingMedium = Font.system(size: 15, weight: .semibold)

    /// 14px semibold
    static let headingSmall = Font.system(size: 14, weight: .semibold)

    // MARK: - Body Fonts (SF Pro)
    // Used for general text content

    /// 17px regular - Page descriptions
    static let bodyLarge = Font.system(size: 17)

    /// 15px regular
    static let bodyMedium = Font.system(size: 15)

    /// 14px regular - Default body text
    static let body = Font.system(size: 14)

    /// 13px regular - Secondary text
    static let bodySmall = Font.system(size: 13)

    /// 12px regular - Tertiary text
    static let caption = Font.system(size: 12)

    // MARK: - Label Fonts (SF Pro)
    // Used for labels, badges, and small text

    /// 11px semibold uppercase - Section labels
    static let label = Font.system(size: 11, weight: .semibold)

    /// 13px medium - Navigation items
    static let navItem = Font.system(size: 14, weight: .medium)

    /// 12px medium - Trend badges
    static let badge = Font.system(size: 12, weight: .medium)

    // MARK: - Monospace (SF Mono)
    // Used for amounts and raw transaction data

    /// 14px - Transaction amounts
    static let monoAmount = Font.system(size: 14, weight: .medium, design: .monospaced)

    /// 12px - Raw descriptions, account balances
    static let monoSmall = Font.system(size: 12, design: .monospaced)
}

// MARK: - Font Registration (call on app launch)

import AppKit

enum FontRegistration {
    static func registerFonts() {
        let fontNames = [
            "SourceSerif4-Light",
            "SourceSerif4-Regular",
            "SourceSerif4-Medium"
        ]

        for fontName in fontNames {
            if let fontURL = Bundle.main.url(forResource: fontName, withExtension: "ttf", subdirectory: "Fonts") {
                CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, nil)
            }
        }
    }
}

// MARK: - Text Styles

struct EnoughTextStyle: ViewModifier {
    let font: Font
    let color: Color
    let tracking: CGFloat

    init(font: Font, color: Color = .textPrimary, tracking: CGFloat = 0) {
        self.font = font
        self.color = color
        self.tracking = tracking
    }

    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(color)
            .tracking(tracking)
    }
}

extension View {
    func enoughTextStyle(_ font: Font, color: Color = .textPrimary, tracking: CGFloat = 0) -> some View {
        modifier(EnoughTextStyle(font: font, color: color, tracking: tracking))
    }

    // MARK: - Preset Text Styles

    /// Large display number (enough amount)
    func displayLargeStyle(color: Color = .sage500) -> some View {
        self
            .font(.displayLarge)
            .foregroundColor(color)
            .tracking(-1.5)
    }

    /// Page title style
    func pageTitleStyle() -> some View {
        self
            .font(.displayTitle)
            .foregroundColor(.textPrimary)
            .tracking(-0.5)
    }

    /// Section label (uppercase)
    func sectionLabelStyle(color: Color = .textTertiary) -> some View {
        self
            .font(.label)
            .foregroundColor(color)
            .tracking(0.5)
            .textCase(.uppercase)
    }

    /// Category amount
    func categoryAmountStyle() -> some View {
        self
            .font(.displayCategory)
            .foregroundColor(.textPrimary)
            .tracking(-0.5)
    }
}
