import SwiftUI
import SwiftData

struct DashboardView: View {
    @Query private var settings: [AppSettings]
    @Query(
        filter: #Predicate<Transaction> { $0.isReviewed },
        sort: \Transaction.date,
        order: .reverse
    ) private var transactions: [Transaction]

    @State private var showingImport = false

    private var currentAppSettings: AppSettings? {
        settings.first
    }

    // Calculate current month spending
    private var currentMonthSpending: Decimal {
        let calendar = Calendar.current
        let now = Date()
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!

        return transactions
            .filter { $0.date >= startOfMonth && $0.amount < 0 }
            .reduce(0) { $0 + abs($1.amount) }
    }

    private var monthlyTarget: Decimal {
        currentAppSettings?.monthlyEnough ?? 7083
    }

    private var progressPercentage: Double {
        guard monthlyTarget > 0 else { return 0 }
        return Double(truncating: (currentMonthSpending / monthlyTarget) as NSDecimalNumber)
    }

    private var remainingAmount: Decimal {
        max(0, monthlyTarget - currentMonthSpending)
    }

    private var recentTransactions: [Transaction] {
        Array(transactions.prefix(5))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.sectionGap) {
                // Header
                header

                // Enough Meter Card
                EnoughMeterCard(
                    currentSpending: currentMonthSpending,
                    monthlyTarget: monthlyTarget,
                    progress: progressPercentage,
                    remaining: remainingAmount
                )

                // Category Grid
                CategoriesGrid(transactions: Array(transactions))

                // Recent Transactions
                RecentTransactionsCard(transactions: recentTransactions)
            }
            .padding(.horizontal, Spacing.contentPadding)
            .padding(.vertical, Spacing.xxxxl)
        }
        .background(Color.enoughCanvas)
        .sheet(isPresented: $showingImport) {
            ImportView()
        }
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(currentMonthName)
                    .font(.displayTitle)
                    .foregroundColor(.textPrimary)

                Text(weekInfo)
                    .font(.body)
                    .foregroundColor(.textTertiary)
            }

            Spacer()

            Button {
                showingImport = true
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.down.doc")
                        .font(.system(size: 14, weight: .medium))

                    Text("Import")
                        .font(.body)
                        .fontWeight(.medium)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 11)
                .background(Color.sage400)
                .clipShape(RoundedRectangle(cornerRadius: Radius.md))
                .primaryButtonShadow()
            }
            .buttonStyle(.plain)
        }
    }

    private var currentMonthName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: Date())
    }

    private var weekInfo: String {
        let calendar = Calendar.current
        let now = Date()

        let weekOfMonth = calendar.component(.weekOfMonth, from: now)
        let range = calendar.range(of: .weekOfMonth, in: .month, for: now)!
        let totalWeeks = range.count

        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: calendar.date(from: calendar.dateComponents([.year, .month], from: now))!)!
        let daysRemaining = calendar.dateComponents([.day], from: now, to: endOfMonth).day ?? 0

        return "Week \(weekOfMonth) of \(totalWeeks) · \(daysRemaining) days remaining"
    }
}

#Preview {
    DashboardView()
        .frame(width: 800, height: 700)
        .modelContainer(for: [Transaction.self, Category.self, AppSettings.self], inMemory: true)
}
