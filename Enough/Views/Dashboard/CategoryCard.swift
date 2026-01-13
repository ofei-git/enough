import SwiftUI

struct CategoryCard: View {
    let categoryType: CategoryType
    let amount: Decimal
    let previousAmount: Decimal?
    let action: () -> Void

    @State private var isHovered = false

    private var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "AUD"
        formatter.maximumFractionDigits = 0
        return formatter.string(from: amount as NSDecimalNumber) ?? "$0"
    }

    private var trend: TrendDirection {
        guard let previous = previousAmount, previous > 0 else {
            return .neutral
        }
        let change = (amount - previous) / previous
        if change > 0.05 {
            return .up(percentage: Int(truncating: (change * 100) as NSDecimalNumber))
        } else if change < -0.05 {
            return .down(percentage: Int(truncating: (abs(change) * 100) as NSDecimalNumber))
        }
        return .neutral
    }

    private var comparisonText: String {
        guard let previous = previousAmount else {
            return "No previous data"
        }
        if previous == amount {
            return "Same as usual"
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "AUD"
        formatter.maximumFractionDigits = 0
        let formatted = formatter.string(from: previous as NSDecimalNumber) ?? "$0"
        return "vs \(formatted) last month"
    }

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 0) {
                // Header with icon and trend
                HStack {
                    CategoryIcon(category: categoryType)

                    Spacer()

                    TrendBadge(trend: trend)
                }
                .padding(.bottom, 16)

                // Category name
                Text(categoryType.displayName)
                    .font(.bodySmall)
                    .fontWeight(.medium)
                    .foregroundColor(.textSecondary)
                    .padding(.bottom, 6)

                // Amount
                Text(formattedAmount)
                    .font(.displayCategory)
                    .foregroundColor(.textPrimary)
                    .padding(.bottom, 4)

                // Comparison
                Text(comparisonText)
                    .font(.caption)
                    .foregroundColor(.textTertiary)
            }
            .padding(Spacing.cardPadding)
            .background(Color.enoughSurface)
            .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
            .cardShadow()
            .offset(y: isHovered ? -2 : 0)
            .shadow(
                color: isHovered ? .black.opacity(0.06) : .black.opacity(0.04),
                radius: isHovered ? 12 : 8,
                x: 0,
                y: isHovered ? 4 : 2
            )
        }
        .buttonStyle(.plain)
        .animation(.easeOut(duration: AnimationDuration.normal), value: isHovered)
        .onHover { hovering in
            isHovered = hovering
        }
    }
}

// MARK: - Trend Direction

enum TrendDirection {
    case up(percentage: Int)
    case down(percentage: Int)
    case neutral

    var badgeText: String {
        switch self {
        case .up(let pct): return "↑ \(pct)%"
        case .down(let pct): return "↓ \(pct)%"
        case .neutral: return "—"
        }
    }

    var backgroundColor: Color {
        switch self {
        case .up: return .warm100
        case .down: return .sage50
        case .neutral: return .enoughCanvas
        }
    }

    var textColor: Color {
        switch self {
        case .up: return .warm500
        case .down: return .sage500
        case .neutral: return .textTertiary
        }
    }
}

// MARK: - Trend Badge

struct TrendBadge: View {
    let trend: TrendDirection

    var body: some View {
        Text(trend.badgeText)
            .font(.badge)
            .foregroundColor(trend.textColor)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(trend.backgroundColor)
            )
    }
}

#Preview {
    HStack(spacing: 16) {
        CategoryCard(
            categoryType: .housing,
            amount: 2100,
            previousAmount: 2100,
            action: {}
        )

        CategoryCard(
            categoryType: .groceries,
            amount: 687,
            previousAmount: 780,
            action: {}
        )

        CategoryCard(
            categoryType: .dining,
            amount: 412,
            previousAmount: 335,
            action: {}
        )
    }
    .padding(40)
    .background(Color.enoughCanvas)
}
