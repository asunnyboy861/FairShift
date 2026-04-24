import SwiftUI

struct PartnerBadge: View {
    let partner: Partner
    var size: CGFloat = 32

    var body: some View {
        ZStack {
            Circle()
                .fill(partner.colorName == "PartnerCoral" ? Color.partnerCoral : Color.partnerTeal)
                .frame(width: size, height: size)

            Text(partner.emoji)
                .font(.system(size: size * 0.55))
        }
    }
}

struct EffortBadge: View {
    let score: Double
    var compact: Bool = false

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "bolt.fill")
                .font(.caption2)
                .foregroundColor(.amber)

            if !compact {
                Text(String(format: "%.0f", score))
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.amber)
            }
        }
        .padding(.horizontal, compact ? 4 : 8)
        .padding(.vertical, 2)
        .background(Color.amber.opacity(0.15))
        .cornerRadius(8)
    }
}

struct CategoryIcon: View {
    let category: ChoreCategory
    var size: CGFloat = 20

    var body: some View {
        Image(systemName: category.icon)
            .font(.system(size: size))
            .foregroundColor(.sageGreen)
    }
}

struct BalanceGauge: View {
    let score: Double
    var size: CGFloat = 120

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.sandBeige, lineWidth: 10)
                .frame(width: size, height: size)

            Circle()
                .trim(from: 0, to: score / 100)
                .stroke(score >= 85 ? Color.sageGreen : score >= 70 ? Color.amber : Color.partnerCoral, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .frame(width: size, height: size)
                .rotationEffect(.degrees(-90))

            VStack(spacing: 2) {
                Text(String(format: "%.0f", score))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                Text("Fairness")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct EmptyStateView: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundColor(.sandBeige)

            Text(title)
                .font(.headline)
                .foregroundColor(.primary)

            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(40)
    }
}
