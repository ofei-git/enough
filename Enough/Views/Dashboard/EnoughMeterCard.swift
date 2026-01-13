import SwiftUI

struct EnoughMeterCard: View {
    let currentSpending: Decimal
    let monthlyTarget: Decimal
    let progress: Double
    let remaining: Decimal

    private var formattedCurrent: String {
        formatCurrency(currentSpending)
    }

    private var formattedTarget: String {
        formatCurrency(monthlyTarget)
    }

    private var formattedRemaining: String {
        formatCurrency(remaining)
    }

    private var statusText: String {
        if progress < 0.8 {
            return "On track"
        } else if progress < 1.0 {
            return "Getting close"
        } else {
            return "Over enough"
        }
    }

    private var statusColor: Color {
        if progress < 0.8 {
            return .sage500
        } else if progress < 1.0 {
            return .warm500
        } else {
            return .categoryHousing
        }
    }

    private var projectionMessage: String {
        let calendar = Calendar.current
        let now = Date()
        let dayOfMonth = calendar.component(.day, from: now)
        let daysInMonth = calendar.range(of: .day, in: .month, for: now)?.count ?? 30

        let projectedSpending = (currentSpending / Decimal(dayOfMonth)) * Decimal(daysInMonth)
        let difference = monthlyTarget - projectedSpending

        if difference > 0 {
            return "At this pace, you'll finish the month about \(formatCurrency(abs(difference))) under your enough number."
        } else {
            return "At this pace, you'll finish the month about \(formatCurrency(abs(difference))) over your enough number."
        }
    }

    var body: some View {
        LargeCardView {
            VStack(alignment: .leading, spacing: 0) {
                // Header
                HStack {
                    Text("THIS MONTH")
                        .font(.label)
                        .foregroundColor(.textTertiary)
                        .tracking(0.3)

                    Spacer()

                    Text("Monthly target: \(formattedTarget)")
                        .font(.bodySmall)
                        .foregroundColor(.textMuted)
                }
                .padding(.bottom, Spacing.sectionGap)

                // Main amount display
                HStack(alignment: .firstTextBaseline, spacing: 16) {
                    Text(formattedCurrent)
                        .font(.displayLarge)
                        .foregroundColor(.sage500)
                        .tracking(-2)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("of your monthly enough")
                            .font(.caption)
                            .foregroundColor(.textMuted)

                        Text(formattedTarget)
                            .font(.displaySmall)
                            .foregroundColor(.textTertiary)
                    }
                }
                .padding(.bottom, Spacing.xxxxl)

                // Progress ring and details
                HStack(alignment: .center, spacing: 32) {
                    ProgressRing.large(progress: min(progress, 1.0))

                    VStack(alignment: .leading, spacing: 8) {
                        // Status
                        HStack(spacing: 8) {
                            Circle()
                                .fill(statusColor)
                                .frame(width: 8, height: 8)

                            Text(statusText)
                                .font(.bodyMedium)
                                .fontWeight(.medium)
                                .foregroundColor(statusColor)
                        }

                        // Projection message
                        Text(projectionMessage)
                            .font(.body)
                            .foregroundColor(.textSecondary)
                            .lineSpacing(4)
                            .frame(maxWidth: 320, alignment: .leading)

                        // Remaining
                        HStack(spacing: 4) {
                            Text(formattedRemaining)
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundColor(.textSecondary)

                            Text("remaining this month")
                                .font(.body)
                                .foregroundColor(.textTertiary)
                        }
                        .padding(.top, 4)
                    }
                }
            }
        }
    }

    private func formatCurrency(_ amount: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "AUD"
        formatter.maximumFractionDigits = 0
        return formatter.string(from: amount as NSDecimalNumber) ?? "$0"
    }
}

#Preview {
    EnoughMeterCard(
        currentSpending: 4847,
        monthlyTarget: 7083,
        progress: 0.68,
        remaining: 2236
    )
    .padding(40)
    .background(Color.enoughCanvas)
}
