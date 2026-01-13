import SwiftUI

struct CategoriesGrid: View {
    let transactions: [Transaction]

    private var categoryTotals: [(CategoryType, Decimal, Decimal?)] {
        let calendar = Calendar.current
        let now = Date()
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
        let startOfLastMonth = calendar.date(byAdding: .month, value: -1, to: startOfMonth)!

        // Group transactions by category
        var currentMonth: [CategoryType: Decimal] = [:]
        var lastMonth: [CategoryType: Decimal] = [:]

        for transaction in transactions where transaction.amount < 0 {
            guard let category = transaction.category?.categoryType else { continue }
            let amount = abs(transaction.amount)

            if transaction.date >= startOfMonth {
                currentMonth[category, default: 0] += amount
            } else if transaction.date >= startOfLastMonth && transaction.date < startOfMonth {
                lastMonth[category, default: 0] += amount
            }
        }

        // Sort by current month spending
        let sorted = currentMonth
            .sorted { $0.value > $1.value }
            .prefix(6)
            .map { (type: $0.key, current: $0.value, previous: lastMonth[$0.key]) }

        return Array(sorted)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if categoryTotals.isEmpty {
                EmptyCategoriesView()
            } else {
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: Spacing.gridGap),
                        GridItem(.flexible(), spacing: Spacing.gridGap),
                        GridItem(.flexible(), spacing: Spacing.gridGap)
                    ],
                    spacing: Spacing.gridGap
                ) {
                    ForEach(categoryTotals, id: \.0) { item in
                        CategoryCard(
                            categoryType: item.0,
                            amount: item.1,
                            previousAmount: item.2,
                            action: {
                                // TODO: Navigate to category detail
                            }
                        )
                    }
                }
            }
        }
    }
}

// MARK: - Empty State

struct EmptyCategoriesView: View {
    var body: some View {
        CardView(hoverEffect: false) {
            VStack(spacing: 16) {
                Image(systemName: "square.grid.2x2")
                    .font(.system(size: 40))
                    .foregroundColor(.textMuted)

                VStack(spacing: 4) {
                    Text("No spending data yet")
                        .font(.headingMedium)
                        .foregroundColor(.textPrimary)

                    Text("Import transactions to see your category breakdown")
                        .font(.bodySmall)
                        .foregroundColor(.textTertiary)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 32)
        }
    }
}

#Preview {
    CategoriesGrid(transactions: [])
        .padding(40)
        .background(Color.enoughCanvas)
}
