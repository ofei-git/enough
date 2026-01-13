import SwiftUI

/// Reusable card container with shadow and hover effects
struct CardView<Content: View>: View {
    let content: Content
    let padding: CGFloat
    let cornerRadius: CGFloat
    let hoverEffect: Bool

    @State private var isHovered = false

    init(
        padding: CGFloat = Spacing.cardPadding,
        cornerRadius: CGFloat = Radius.lg,
        hoverEffect: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.padding = padding
        self.cornerRadius = cornerRadius
        self.hoverEffect = hoverEffect
        self.content = content()
    }

    var body: some View {
        content
            .padding(padding)
            .background(Color.enoughSurface)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .cardShadow()
            .offset(y: isHovered && hoverEffect ? -2 : 0)
            .shadow(
                color: isHovered ? .black.opacity(0.06) : .black.opacity(0.04),
                radius: isHovered ? 12 : 8,
                x: 0,
                y: isHovered ? 4 : 2
            )
            .animation(.easeOut(duration: AnimationDuration.normal), value: isHovered)
            .onHover { hovering in
                isHovered = hovering
            }
    }
}

// MARK: - Large Card Variant

struct LargeCardView<Content: View>: View {
    let content: Content

    @State private var isHovered = false

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(Spacing.cardPaddingLarge)
            .background(Color.enoughSurface)
            .clipShape(RoundedRectangle(cornerRadius: Radius.xl))
            .cardShadow()
    }
}

// MARK: - Clickable Card

struct ClickableCardView<Content: View>: View {
    let action: () -> Void
    let content: Content

    @State private var isHovered = false
    @State private var isPressed = false

    init(action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.action = action
        self.content = content()
    }

    var body: some View {
        Button(action: action) {
            content
                .padding(Spacing.cardPadding)
                .background(Color.enoughSurface)
                .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
        }
        .buttonStyle(CardButtonStyle())
    }
}

struct CardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .cardShadow()
            .offset(y: configuration.isPressed ? 0 : -2)
            .shadow(
                color: .black.opacity(configuration.isPressed ? 0.04 : 0.06),
                radius: configuration.isPressed ? 8 : 12,
                x: 0,
                y: configuration.isPressed ? 2 : 4
            )
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    VStack(spacing: 24) {
        CardView {
            VStack(alignment: .leading, spacing: 8) {
                Text("Regular Card")
                    .font(.headingMedium)
                Text("This card has a hover effect")
                    .font(.bodySmall)
                    .foregroundColor(.textSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }

        LargeCardView {
            VStack(alignment: .leading, spacing: 8) {
                Text("Large Card")
                    .font(.headingLarge)
                Text("More padding for important content")
                    .font(.body)
                    .foregroundColor(.textSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    .padding(40)
    .frame(width: 400)
    .background(Color.enoughCanvas)
}
