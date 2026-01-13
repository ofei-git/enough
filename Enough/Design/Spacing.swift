import SwiftUI

// MARK: - Enough Spacing & Radius Constants
// Consistent spacing creates visual rhythm

enum Spacing {
    // MARK: - Base Spacing Scale
    static let xxs: CGFloat = 4
    static let xs: CGFloat = 6
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 20
    static let xxl: CGFloat = 24
    static let xxxl: CGFloat = 28
    static let xxxxl: CGFloat = 32

    // MARK: - Component-Specific Spacing

    /// Padding inside cards
    static let cardPadding: CGFloat = 22

    /// Padding for larger cards (enough meter)
    static let cardPaddingLarge: CGFloat = 36

    /// Sidebar padding
    static let sidebarPadding: CGFloat = 16

    /// Main content padding
    static let contentPadding: CGFloat = 40

    /// Section gap between major elements
    static let sectionGap: CGFloat = 28

    /// Gap between grid items
    static let gridGap: CGFloat = 16

    /// Navigation item padding
    static let navItemPadding: CGFloat = 10

    /// Icon size for navigation
    static let navIconSize: CGFloat = 20

    /// Transaction row padding
    static let transactionRowPadding: CGFloat = 16

    /// Category icon container size
    static let categoryIconSize: CGFloat = 40

    /// Small category icon (in transaction rows)
    static let smallIconSize: CGFloat = 36
}

// MARK: - Border Radius

enum Radius {
    /// Small radius (8px) - buttons, small elements
    static let sm: CGFloat = 8

    /// Medium radius (12px) - cards, inputs
    static let md: CGFloat = 12

    /// Large radius (16px) - larger cards
    static let lg: CGFloat = 16

    /// Extra large radius (20px) - main containers
    static let xl: CGFloat = 20

    /// Full radius for pills and badges
    static let full: CGFloat = 100
}

// MARK: - Layout Constants

enum Layout {
    /// Sidebar width
    static let sidebarWidth: CGFloat = 240

    /// Maximum content width for main area (prevents stretching on large screens)
    static let maxContentWidth: CGFloat = 860

    /// Minimum window width
    static let minWindowWidth: CGFloat = 900

    /// Minimum window height
    static let minWindowHeight: CGFloat = 600

    /// Titlebar height
    static let titlebarHeight: CGFloat = 52

    /// Progress ring size
    static let progressRingSize: CGFloat = 120

    /// Progress ring stroke width
    static let progressRingStroke: CGFloat = 8

    /// Account indicator dot size
    static let accountDotSize: CGFloat = 8

    /// Traffic light button size
    static let trafficLightSize: CGFloat = 12

    /// Icon stroke width
    static let iconStroke: CGFloat = 1.5

    /// Category grid columns
    static let categoryGridColumns: Int = 3
}

// MARK: - Animation Durations

enum AnimationDuration {
    /// Fast transitions (hover states)
    static let fast: Double = 0.15

    /// Normal transitions
    static let normal: Double = 0.2

    /// Slow transitions (progress ring)
    static let slow: Double = 0.6

    /// Spring animation response
    static let springResponse: Double = 0.3

    /// Spring animation damping
    static let springDamping: Double = 0.7
}

// MARK: - View Extensions for Spacing

extension View {
    /// Apply standard card padding
    func cardPadding() -> some View {
        self.padding(Spacing.cardPadding)
    }

    /// Apply large card padding
    func largeCardPadding() -> some View {
        self.padding(Spacing.cardPaddingLarge)
    }

    /// Apply content area padding
    func contentPadding() -> some View {
        self.padding(.horizontal, Spacing.contentPadding)
            .padding(.vertical, Spacing.xxxxl)
    }
}
