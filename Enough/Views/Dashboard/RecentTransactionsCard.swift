import SwiftUI

struct RecentTransactionsCard: View {
    let transactions: [Transaction]

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Recent")
                    .font(.headingSmall)
                    .foregroundColor(.textPrimary)

                Spacer()

                Button {
                    NotificationCenter.default.post(
                        name: NSNotification.Name("navigateToTransactions"),
                        object: nil
                    )
                } label: {
                    Text("See all →")
                        .font(.bodySmall)
                        .fontWeight(.medium)
                        .foregroundColor(.sage400)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 18)
            .background(Color.enoughSurface)

            Divider()

            // Transaction list
            if transactions.isEmpty {
                EmptyTransactionsView()
            } else {
                ForEach(Array(transactions.enumerated()), id: \.element.id) { index, transaction in
                    TransactionRow(transaction: transaction)

                    if index < transactions.count - 1 {
                        Divider()
                            .padding(.leading, 80)
                    }
                }
            }
        }
        .background(Color.enoughSurface)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
        .cardShadow()
    }
}

// MARK: - Empty State

struct EmptyTransactionsView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "doc.text")
                .font(.system(size: 32))
                .foregroundColor(.textMuted)

            Text("No transactions yet")
                .font(.bodySmall)
                .foregroundColor(.textTertiary)

            Button {
                NotificationCenter.default.post(name: .showImport, object: nil)
            } label: {
                Text("Import your first CSV")
                    .font(.bodySmall)
                    .fontWeight(.medium)
                    .foregroundColor(.sage400)
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
}

// MARK: - Static Preview Data

struct RecentTransactionsCard_Previews: PreviewProvider {
    static var previews: some View {
        // Using CompactTransactionRow for preview since we don't have real Transaction objects
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Recent")
                    .font(.headingSmall)
                    .foregroundColor(.textPrimary)

                Spacer()

                Text("See all →")
                    .font(.bodySmall)
                    .fontWeight(.medium)
                    .foregroundColor(.sage400)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 18)
            .background(Color.enoughSurface)

            Divider()

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
        .cardShadow()
        .padding(40)
        .background(Color.enoughCanvas)
    }
}
