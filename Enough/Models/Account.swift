import Foundation
import SwiftData
import SwiftUI

@Model
final class Account {
    var id: UUID
    var name: String
    var bank: BankType
    var accountType: AccountType
    var colorHex: String
    var sortOrder: Int
    var isActive: Bool
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \Transaction.account)
    var transactions: [Transaction]?

    init(
        name: String,
        bank: BankType = .other,
        accountType: AccountType = .checking,
        colorHex: String = "7A9A7E",
        sortOrder: Int = 0
    ) {
        self.id = UUID()
        self.name = name
        self.bank = bank
        self.accountType = accountType
        self.colorHex = colorHex
        self.sortOrder = sortOrder
        self.isActive = true
        self.createdAt = Date()
    }

    var color: Color {
        Color(hex: colorHex)
    }

    var balance: Decimal {
        (transactions ?? [])
            .filter { $0.isReviewed }
            .reduce(0) { $0 + $1.amount }
    }
}

// MARK: - Bank Type

enum BankType: String, Codable, CaseIterable {
    case ing = "ING"
    case cba = "CBA"
    case anz = "ANZ"
    case westpac = "Westpac"
    case nab = "NAB"
    case up = "Up"
    case macquarie = "Macquarie"
    case other = "Other"

    var displayName: String {
        switch self {
        case .ing: return "ING Australia"
        case .cba: return "Commonwealth Bank"
        case .anz: return "ANZ"
        case .westpac: return "Westpac"
        case .nab: return "NAB"
        case .up: return "Up"
        case .macquarie: return "Macquarie"
        case .other: return "Other"
        }
    }
}

// MARK: - Account Type

enum AccountType: String, Codable, CaseIterable {
    case checking
    case savings
    case credit

    var displayName: String {
        switch self {
        case .checking: return "Everyday"
        case .savings: return "Savings"
        case .credit: return "Credit Card"
        }
    }
}
