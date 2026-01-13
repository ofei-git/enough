import Foundation
import SwiftData

@Model
final class Transaction {
    var id: UUID
    var date: Date
    var amount: Decimal
    var rawDescription: String
    var isManual: Bool
    var isReviewed: Bool
    var importedAt: Date
    var reviewedAt: Date?

    @Relationship
    var account: Account?

    @Relationship
    var merchant: Merchant?

    @Relationship
    var category: Category?

    init(
        date: Date,
        amount: Decimal,
        rawDescription: String,
        account: Account? = nil,
        isManual: Bool = false
    ) {
        self.id = UUID()
        self.date = date
        self.amount = amount
        self.rawDescription = rawDescription
        self.account = account
        self.isManual = isManual
        self.isReviewed = false
        self.importedAt = Date()
    }

    /// Display name from merchant or cleaned description
    var displayName: String {
        merchant?.displayName ?? cleanedDescription
    }

    /// Cleaned version of raw description
    var cleanedDescription: String {
        // Remove common noise patterns
        var cleaned = rawDescription
            .replacingOccurrences(of: "EFTPOS ", with: "")
            .replacingOccurrences(of: "VISA PURCHASE ", with: "")
            .replacingOccurrences(of: " AU$", with: "")

        // Title case if all caps
        if cleaned == cleaned.uppercased() {
            cleaned = cleaned.capitalized
        }

        return cleaned.trimmingCharacters(in: .whitespaces)
    }

    /// Category display name
    var categoryName: String {
        category?.name ?? "Uncategorized"
    }

    /// Whether this transaction needs review
    var needsReview: Bool {
        !isReviewed && category == nil
    }

    /// Formatted amount string
    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "AUD"
        return formatter.string(from: amount as NSDecimalNumber) ?? "$0.00"
    }

    /// Formatted date string
    var formattedDate: String {
        let formatter = DateFormatter()
        let calendar = Calendar.current

        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else if calendar.isDate(date, equalTo: Date(), toGranularity: .weekOfYear) {
            formatter.dateFormat = "EEEE"
            return formatter.string(from: date)
        } else {
            formatter.dateFormat = "d MMM"
            return formatter.string(from: date)
        }
    }
}

// MARK: - Transaction Helpers

extension Transaction {
    /// Check if this transaction is a duplicate of another
    func isDuplicate(of other: Transaction) -> Bool {
        date == other.date &&
        amount == other.amount &&
        rawDescription == other.rawDescription
    }
}
