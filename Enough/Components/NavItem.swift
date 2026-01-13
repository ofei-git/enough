import SwiftUI

/// Sidebar navigation item with icon and active state
struct NavItem: View {
    let title: String
    let icon: String
    let isActive: Bool
    let action: () -> Void

    @State private var isHovered = false

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .regular))
                    .frame(width: Spacing.navIconSize, height: Spacing.navIconSize)
                    .opacity(isActive ? 1 : 0.7)

                Text(title)
                    .font(.navItem)

                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, Spacing.navItemPadding)
            .foregroundColor(isActive ? .white : (isHovered ? .textPrimary : .textSecondary))
            .background(
                RoundedRectangle(cornerRadius: Radius.sm)
                    .fill(isActive ? Color.sage400 : (isHovered ? Color.hoverBackground : .clear))
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            isHovered = hovering
        }
    }
}

// MARK: - Account Item

struct AccountItem: View {
    let name: String
    let balance: Decimal
    let color: Color
    let action: () -> Void

    @State private var isHovered = false

    private var formattedBalance: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "AUD"
        formatter.maximumFractionDigits = 0
        return formatter.string(from: balance as NSDecimalNumber) ?? "$0"
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Circle()
                    .fill(color)
                    .frame(width: Layout.accountDotSize, height: Layout.accountDotSize)

                Text(name)
                    .font(.bodySmall)
                    .foregroundColor(.textSecondary)

                Spacer()

                Text(formattedBalance)
                    .font(.monoSmall)
                    .foregroundColor(.textTertiary)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: Radius.sm)
                    .fill(isHovered ? Color.hoverBackground : .clear)
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            isHovered = hovering
        }
    }
}

// MARK: - Enough Badge (Sidebar Footer)

struct EnoughBadge: View {
    let yearlyAmount: Decimal

    private var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "AUD"
        formatter.maximumFractionDigits = 0
        return formatter.string(from: yearlyAmount as NSDecimalNumber) ?? "$0"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("YOUR ENOUGH")
                .font(.label)
                .foregroundColor(.warm500)
                .tracking(0.5)

            Text(formattedAmount)
                .font(.displayBadge)
                .foregroundColor(.textPrimary)

            Text("per year")
                .font(.caption)
                .foregroundColor(.textTertiary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: Radius.md)
                .fill(Color.warm100)
                .overlay(
                    RoundedRectangle(cornerRadius: Radius.md)
                        .strokeBorder(Color.warm200, lineWidth: 1)
                )
        )
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 8) {
        NavItem(title: "Overview", icon: "square.grid.2x2", isActive: true) {}
        NavItem(title: "Transactions", icon: "list.bullet", isActive: false) {}
        NavItem(title: "Trends", icon: "chart.xyaxis.line", isActive: false) {}

        Divider()
            .padding(.vertical, 12)

        Text("ACCOUNTS")
            .sectionLabelStyle()
            .padding(.horizontal, 12)
            .padding(.bottom, 4)

        AccountItem(name: "ING Joint", balance: 12450, color: .sage400) {}
        AccountItem(name: "ING Personal", balance: 3210, color: .warm400) {}
        AccountItem(name: "Up Savings", balance: 8500, color: .purple) {}

        Spacer()

        EnoughBadge(yearlyAmount: 85000)
    }
    .padding(Spacing.sidebarPadding)
    .frame(width: Layout.sidebarWidth)
    .background(Color.enoughSidebar)
}
