import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction

    @State private var isHovered = false

    var body: some View {
        HStack(spacing: 16) {
            // Category icon
            transactionIcon

            // Details
            VStack(alignment: .leading, spacing: 2) {
                Text(transaction.displayName)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.textPrimary)

                Text(transaction.categoryName)
                    .font(.caption)
                    .foregroundColor(.textTertiary)
            }

            Spacer()

            // Amount and date
            VStack(alignment: .trailing, spacing: 2) {
                Text(transaction.formattedAmount)
                    .font(.monoAmount)
                    .foregroundColor(.textPrimary)

                Text(transaction.formattedDate)
                    .font(.caption)
                    .foregroundColor(.textMuted)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, Spacing.transactionRowPadding)
        .background(isHovered ? Color.enoughCanvas : .clear)
        .onHover { hovering in
            isHovered = hovering
        }
    }

    @ViewBuilder
    private var transactionIcon: some View {
        if let category = transaction.category,
           let type = category.categoryType {
            CategoryIcon(category: type, size: Spacing.categoryIconSize)
        } else {
            // Default icon for uncategorized
            ZStack {
                RoundedRectangle(cornerRadius: Radius.md)
                    .fill(Color.enoughCanvas)
                    .frame(width: Spacing.categoryIconSize, height: Spacing.categoryIconSize)

                Image(systemName: "questionmark")
                    .font(.system(size: 16))
                    .foregroundColor(.textTertiary)
            }
        }
    }
}

// MARK: - Compact Transaction Row (for dashboard)

struct CompactTransactionRow: View {
    let merchantName: String
    let category: String
    let amount: String
    let date: String
    let categoryType: CategoryType?

    @State private var isHovered = false

    var body: some View {
        HStack(spacing: 16) {
            // Category icon
            if let type = categoryType {
                CategoryIcon(category: type, size: Spacing.categoryIconSize)
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: Radius.md)
                        .fill(Color.enoughCanvas)
                        .frame(width: Spacing.categoryIconSize, height: Spacing.categoryIconSize)

                    Image(systemName: "circle")
                        .font(.system(size: 16))
                        .foregroundColor(.textTertiary)
                }
            }

            // Details
            VStack(alignment: .leading, spacing: 2) {
                Text(merchantName)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.textPrimary)

                Text(category)
                    .font(.caption)
                    .foregroundColor(.textTertiary)
            }

            Spacer()

            // Amount and date
            VStack(alignment: .trailing, spacing: 2) {
                Text(amount)
                    .font(.monoAmount)
                    .foregroundColor(.textPrimary)

                Text(date)
                    .font(.caption)
                    .foregroundColor(.textMuted)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, Spacing.transactionRowPadding)
        .background(isHovered ? Color.enoughCanvas : .clear)
        .onHover { hovering in
            isHovered = hovering
        }
    }
}

#Preview {
    VStack(spacing: 0) {
        CompactTransactionRow(
            merchantName: "Coles Supermarket",
            category: "Groceries",
            amount: "-$127.45",
            date: "Today",
            categoryType: .groceries
        )

        Divider()
            .padding(.leading, 80)

        CompactTransactionRow(
            merchantName: "Frankie's Coffee House",
            category: "Dining",
            amount: "-$8.50",
            date: "Today",
            categoryType: .dining
        )

        Divider()
            .padding(.leading, 80)

        CompactTransactionRow(
            merchantName: "BP Service Station",
            category: "Transport",
            amount: "-$89.30",
            date: "Yesterday",
            categoryType: .transport
        )
    }
    .background(Color.enoughSurface)
    .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
    .padding(40)
    .background(Color.enoughCanvas)
}
