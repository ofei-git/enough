import SwiftUI

/// The signature circular progress indicator
/// Shows percentage of "enough" used with gradient fill
struct ProgressRing: View {
    let progress: Double // 0.0 to 1.0
    let size: CGFloat
    let lineWidth: CGFloat
    let showLabel: Bool

    init(
        progress: Double,
        size: CGFloat = Layout.progressRingSize,
        lineWidth: CGFloat = Layout.progressRingStroke,
        showLabel: Bool = true
    ) {
        self.progress = min(max(progress, 0), 1) // Clamp to 0-1
        self.size = size
        self.lineWidth = lineWidth
        self.showLabel = showLabel
    }

    var body: some View {
        ZStack {
            // Background ring
            Circle()
                .stroke(Color.sage100, lineWidth: lineWidth)

            // Progress ring with gradient
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [
                            Color(hex: "9BC49E"),
                            Color.sage400
                        ]),
                        center: .center,
                        startAngle: .degrees(-90),
                        endAngle: .degrees(270)
                    ),
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: AnimationDuration.slow), value: progress)

            // Center label
            if showLabel {
                VStack(spacing: 4) {
                    Text("\(Int(progress * 100))%")
                        .font(.custom("SourceSerif4-Regular", size: size * 0.23))
                        .foregroundColor(.textPrimary)

                    Text("used")
                        .font(.system(size: 11))
                        .foregroundColor(.textTertiary)
                }
            }
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Progress Ring Variants

extension ProgressRing {
    /// Small inline progress ring without label
    static func small(progress: Double) -> ProgressRing {
        ProgressRing(progress: progress, size: 32, lineWidth: 3, showLabel: false)
    }

    /// Medium progress ring for cards
    static func medium(progress: Double) -> ProgressRing {
        ProgressRing(progress: progress, size: 80, lineWidth: 6, showLabel: true)
    }

    /// Large progress ring for dashboard
    static func large(progress: Double) -> ProgressRing {
        ProgressRing(progress: progress, size: 120, lineWidth: 8, showLabel: true)
    }
}

#Preview {
    HStack(spacing: 40) {
        ProgressRing.small(progress: 0.68)
        ProgressRing.medium(progress: 0.68)
        ProgressRing.large(progress: 0.68)
    }
    .padding(40)
    .background(Color.enoughCanvas)
}
