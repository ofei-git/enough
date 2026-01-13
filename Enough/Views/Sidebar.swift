import SwiftUI
import SwiftData

struct Sidebar: View {
    @Binding var selectedDestination: NavigationDestination

    @Query(sort: \Account.sortOrder) private var accounts: [Account]
    @Query private var settings: [AppSettings]

    private var currentAppSettings: AppSettings? {
        settings.first
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Navigation Section
            VStack(alignment: .leading, spacing: 4) {
                NavItem(
                    title: "Overview",
                    icon: "square.grid.2x2",
                    isActive: selectedDestination == .overview
                ) {
                    selectedDestination = .overview
                }

                NavItem(
                    title: "Transactions",
                    icon: "list.bullet",
                    isActive: selectedDestination == .transactions
                ) {
                    selectedDestination = .transactions
                }

                NavItem(
                    title: "Trends",
                    icon: "chart.xyaxis.line",
                    isActive: selectedDestination == .trends
                ) {
                    selectedDestination = .trends
                }
            }
            .padding(.bottom, Spacing.sectionGap)

            // Accounts Section
            VStack(alignment: .leading, spacing: 4) {
                Text("ACCOUNTS")
                    .sectionLabelStyle()
                    .padding(.horizontal, 12)
                    .padding(.bottom, 4)

                if accounts.isEmpty {
                    EmptyAccountsView()
                } else {
                    ForEach(accounts) { account in
                        AccountItem(
                            name: account.name,
                            balance: account.balance,
                            color: account.color
                        ) {
                            // TODO: Show account detail
                        }
                    }
                }
            }

            Spacer()

            // Footer with Enough Badge
            VStack {
                Divider()
                    .padding(.bottom, Spacing.lg)

                if let settings = currentAppSettings {
                    EnoughBadge(yearlyAmount: settings.enoughNumber)
                }
            }
        }
        .padding(Spacing.sidebarPadding)
        .padding(.top, 4)
        .background(Color.enoughSidebar)
    }
}

// MARK: - Empty Accounts View

struct EmptyAccountsView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "building.columns")
                .font(.system(size: 24))
                .foregroundColor(.textMuted)

            Text("No accounts yet")
                .font(.bodySmall)
                .foregroundColor(.textTertiary)

            Text("Import a CSV to get started")
                .font(.caption)
                .foregroundColor(.textMuted)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
    }
}

#Preview {
    HStack(spacing: 0) {
        Sidebar(selectedDestination: .constant(.overview))
            .frame(width: Layout.sidebarWidth)

        Color.enoughCanvas
    }
    .frame(width: 600, height: 500)
    .modelContainer(for: [Account.self, AppSettings.self], inMemory: true)
}
