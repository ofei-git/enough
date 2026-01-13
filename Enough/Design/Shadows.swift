import SwiftUI

// MARK: - Enough Shadow System
// Multiple shadow levels create hierarchy and depth

struct EnoughShadow {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
}

extension EnoughShadow {
    /// Subtle shadow for minor elevation
    static let sm = EnoughShadow(
        color: .black.opacity(0.04),
        radius: 2,
        x: 0,
        y: 1
    )

    /// Medium shadow for cards
    static let md = EnoughShadow(
        color: .black.opacity(0.06),
        radius: 12,
        x: 0,
        y: 4
    )

    /// Large shadow for elevated elements
    static let lg = EnoughShadow(
        color: .black.opacity(0.08),
        radius: 24,
        x: 0,
        y: 8
    )

    /// Card shadow - subtle with slight border effect
    static let card = EnoughShadow(
        color: .black.opacity(0.04),
        radius: 8,
        x: 0,
        y: 2
    )

    /// Elevated shadow for windows and modals
    static let elevated = EnoughShadow(
        color: .black.opacity(0.1),
        radius: 32,
        x: 0,
        y: 12
    )

    /// Button shadow - colored shadow for primary buttons
    static func button(color: Color = .sage400) -> EnoughShadow {
        EnoughShadow(
            color: color.opacity(0.25),
            radius: 8,
            x: 0,
            y: 2
        )
    }

    /// Hover state button shadow
    static func buttonHover(color: Color = .sage400) -> EnoughShadow {
        EnoughShadow(
            color: color.opacity(0.3),
            radius: 12,
            x: 0,
            y: 4
        )
    }
}

// MARK: - Shadow View Modifier

struct ShadowModifier: ViewModifier {
    let shadow: EnoughShadow

    func body(content: Content) -> some View {
        content
            .shadow(
                color: shadow.color,
                radius: shadow.radius,
                x: shadow.x,
                y: shadow.y
            )
    }
}

extension View {
    func enoughShadow(_ shadow: EnoughShadow) -> some View {
        modifier(ShadowModifier(shadow: shadow))
    }

    /// Card style shadow
    func cardShadow() -> some View {
        self
            .shadow(color: .black.opacity(0.04), radius: 8, x: 0, y: 2)
            .shadow(color: .black.opacity(0.02), radius: 1, x: 0, y: 0) // Subtle border effect
    }

    /// Medium elevation shadow
    func mediumShadow() -> some View {
        self
            .shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 4)
            .shadow(color: .black.opacity(0.04), radius: 3, x: 0, y: 1)
    }

    /// Large elevation shadow
    func elevatedShadow() -> some View {
        self
            .shadow(color: .black.opacity(0.1), radius: 32, x: 0, y: 12)
            .shadow(color: .black.opacity(0.05), radius: 12, x: 0, y: 4)
    }

    /// Primary button shadow
    func primaryButtonShadow() -> some View {
        self.shadow(color: Color.sage400.opacity(0.25), radius: 8, x: 0, y: 2)
    }
}
