import SwiftUI

/// Color-coded icon container for categories
struct CategoryIcon: View {
    let category: CategoryType
    let size: CGFloat

    init(category: CategoryType, size: CGFloat = Spacing.categoryIconSize) {
        self.category = category
        self.size = size
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Radius.md)
                .fill(category.backgroundColor)
                .frame(width: size, height: size)

            Image(systemName: category.iconName)
                .font(.system(size: size * 0.45, weight: .regular))
                .foregroundColor(category.iconColor)
        }
    }
}

// MARK: - Category Type

enum CategoryType: String, CaseIterable, Identifiable, Codable {
    case housing
    case utilities
    case groceries
    case dining
    case transport
    case health
    case subscriptions
    case shopping
    case entertainment
    case travel
    case insurance
    case personalCare
    case gifts
    case education
    case other

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .housing: return "Housing"
        case .utilities: return "Utilities"
        case .groceries: return "Groceries"
        case .dining: return "Dining"
        case .transport: return "Transport"
        case .health: return "Health"
        case .subscriptions: return "Subscriptions"
        case .shopping: return "Shopping"
        case .entertainment: return "Entertainment"
        case .travel: return "Travel"
        case .insurance: return "Insurance"
        case .personalCare: return "Personal Care"
        case .gifts: return "Gifts"
        case .education: return "Education"
        case .other: return "Other"
        }
    }

    var hint: String {
        switch self {
        case .housing: return "Rent, mortgage, property"
        case .utilities: return "Power, water, internet"
        case .groceries: return "Supermarkets, food shopping"
        case .dining: return "Restaurants, cafes, takeaway"
        case .transport: return "Fuel, transit, car costs"
        case .health: return "Medical, dental, fitness"
        case .subscriptions: return "Recurring digital services"
        case .shopping: return "General retail purchases"
        case .entertainment: return "Events, streaming, hobbies"
        case .travel: return "Flights, hotels, holidays"
        case .insurance: return "Health, home, car policies"
        case .personalCare: return "Haircuts, beauty, self-care"
        case .gifts: return "Presents, donations, charity"
        case .education: return "Courses, books, learning"
        case .other: return "Everything else"
        }
    }

    var iconName: String {
        switch self {
        case .housing: return "house"
        case .utilities: return "bolt"
        case .groceries: return "cart"
        case .dining: return "cup.and.saucer"
        case .transport: return "car"
        case .health: return "heart"
        case .subscriptions: return "repeat"
        case .shopping: return "bag"
        case .entertainment: return "tv"
        case .travel: return "airplane"
        case .insurance: return "shield"
        case .personalCare: return "sparkles"
        case .gifts: return "gift"
        case .education: return "book"
        case .other: return "ellipsis"
        }
    }

    var iconColor: Color {
        switch self {
        case .housing: return .categoryHousing
        case .utilities: return .categoryUtilities
        case .groceries: return .categoryGroceries
        case .dining: return .categoryDining
        case .transport: return .categoryTransport
        case .health: return .categoryHealth
        case .subscriptions: return .categorySubscriptions
        case .shopping: return .categoryShopping
        case .entertainment: return .categoryEntertainment
        case .travel: return .categoryTravel
        case .insurance: return .categoryInsurance
        case .personalCare: return .categoryPersonalCare
        case .gifts: return .categoryGifts
        case .education: return .categoryEducation
        case .other: return .categoryOther
        }
    }

    var backgroundColor: Color {
        iconColor.opacity(0.12)
    }
}

#Preview {
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 16) {
        ForEach(CategoryType.allCases) { category in
            VStack(spacing: 8) {
                CategoryIcon(category: category)
                Text(category.displayName)
                    .font(.caption)
                    .foregroundColor(.textSecondary)
            }
        }
    }
    .padding(40)
    .background(Color.enoughCanvas)
}
