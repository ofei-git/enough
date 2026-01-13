import Foundation
import SwiftData

@Model
final class AppSettings {
    var id: UUID
    var enoughNumber: Decimal
    var reviewDay: ReviewDay
    var onboardingComplete: Bool
    var createdAt: Date
    var updatedAt: Date

    init(
        enoughNumber: Decimal = 85000,
        reviewDay: ReviewDay = .sunday
    ) {
        self.id = UUID()
        self.enoughNumber = enoughNumber
        self.reviewDay = reviewDay
        self.onboardingComplete = false
        self.createdAt = Date()
        self.updatedAt = Date()
    }

    /// Monthly enough number (yearly / 12)
    var monthlyEnough: Decimal {
        enoughNumber / 12
    }

    /// Weekly enough number (yearly / 52)
    var weeklyEnough: Decimal {
        enoughNumber / 52
    }

    /// Formatted yearly enough
    var formattedYearly: String {
        formatCurrency(enoughNumber)
    }

    /// Formatted monthly enough
    var formattedMonthly: String {
        formatCurrency(monthlyEnough)
    }

    private func formatCurrency(_ amount: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "AUD"
        formatter.maximumFractionDigits = 0
        return formatter.string(from: amount as NSDecimalNumber) ?? "$0"
    }
}

// MARK: - Review Day

enum ReviewDay: String, Codable, CaseIterable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday

    var displayName: String {
        rawValue.capitalized
    }

    var weekdayNumber: Int {
        switch self {
        case .sunday: return 1
        case .monday: return 2
        case .tuesday: return 3
        case .wednesday: return 4
        case .thursday: return 5
        case .friday: return 6
        case .saturday: return 7
        }
    }
}
