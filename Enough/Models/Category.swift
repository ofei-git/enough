import Foundation
import SwiftData
import SwiftUI

@Model
final class Category {
    var id: UUID
    var name: String
    var iconName: String
    var colorHex: String
    var sortOrder: Int
    var isDefault: Bool
    var createdAt: Date

    @Relationship(deleteRule: .nullify, inverse: \Transaction.category)
    var transactions: [Transaction]?

    @Relationship(deleteRule: .nullify, inverse: \Merchant.defaultCategory)
    var merchants: [Merchant]?

    init(
        name: String,
        iconName: String,
        colorHex: String,
        sortOrder: Int = 0,
        isDefault: Bool = true
    ) {
        self.id = UUID()
        self.name = name
        self.iconName = iconName
        self.colorHex = colorHex
        self.sortOrder = sortOrder
        self.isDefault = isDefault
        self.createdAt = Date()
    }

    var color: Color {
        Color(hex: colorHex)
    }

    var backgroundColor: Color {
        color.opacity(0.12)
    }

    /// Get the CategoryType for this category if it matches a default
    var categoryType: CategoryType? {
        CategoryType.allCases.first { $0.displayName == name }
    }
}

// MARK: - Default Categories

extension Category {
    static var defaults: [Category] {
        CategoryType.allCases.enumerated().map { index, type in
            Category(
                name: type.displayName,
                iconName: type.iconName,
                colorHex: type.colorHex,
                sortOrder: index,
                isDefault: true
            )
        }
    }
}

// MARK: - CategoryType Hex Colors

extension CategoryType {
    var colorHex: String {
        switch self {
        case .housing: return "D06050"
        case .utilities: return "84CC16"
        case .groceries: return "5C7D60"
        case .dining: return "A67D54"
        case .transport: return "3B82F6"
        case .health: return "10B981"
        case .subscriptions: return "6366F1"
        case .shopping: return "9333EA"
        case .entertainment: return "EC4899"
        case .travel: return "F59E0B"
        case .insurance: return "64748B"
        case .personalCare: return "A855F7"
        case .gifts: return "EF4444"
        case .education: return "0EA5E9"
        case .other: return "9CA3AF"
        }
    }
}
