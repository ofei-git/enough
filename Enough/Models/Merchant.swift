import Foundation
import SwiftData

@Model
final class Merchant {
    var id: UUID
    var rawPattern: String
    var displayName: String
    var createdAt: Date

    @Relationship
    var defaultCategory: Category?

    @Relationship(deleteRule: .nullify, inverse: \Transaction.merchant)
    var transactions: [Transaction]?

    init(rawPattern: String, displayName: String, defaultCategory: Category? = nil) {
        self.id = UUID()
        self.rawPattern = rawPattern
        self.displayName = displayName
        self.defaultCategory = defaultCategory
        self.createdAt = Date()
    }

    /// Check if a raw description matches this merchant's pattern
    func matches(_ description: String) -> Bool {
        description.localizedCaseInsensitiveContains(rawPattern)
    }
}

// MARK: - Merchant Factory

extension Merchant {
    /// Create a merchant from a transaction's raw description
    static func from(transaction: Transaction, displayName: String? = nil, category: Category? = nil) -> Merchant {
        // Extract a pattern from the description
        let pattern = extractPattern(from: transaction.rawDescription)
        let name = displayName ?? transaction.cleanedDescription

        return Merchant(rawPattern: pattern, displayName: name, defaultCategory: category)
    }

    /// Extract a reusable pattern from a raw description
    private static func extractPattern(from description: String) -> String {
        // Remove variable parts (amounts, dates, reference numbers)
        var pattern = description

        // Remove trailing numbers and references
        let numberPattern = #"\s*\d{4,}.*$"#
        if let range = pattern.range(of: numberPattern, options: .regularExpression) {
            pattern.removeSubrange(range)
        }

        // Remove common prefixes
        let prefixes = ["EFTPOS ", "VISA PURCHASE ", "DIRECT DEBIT "]
        for prefix in prefixes {
            if pattern.hasPrefix(prefix) {
                pattern = String(pattern.dropFirst(prefix.count))
            }
        }

        return pattern.trimmingCharacters(in: .whitespaces)
    }
}
