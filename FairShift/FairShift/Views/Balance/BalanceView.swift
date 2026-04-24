import SwiftUI
import SwiftData

struct BalanceView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Partner.createdAt) private var partners: [Partner]
    @State private var viewModel = BalanceViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    if partners.count >= 2 {
                        fairnessGauge
                        ownershipBreakdown
                        insightsSection
                    } else {
                        EmptyStateView(
                            icon: "scale.3d",
                            title: "Set Up Partners First",
                            subtitle: "Add both partners to see your balance analysis"
                        )
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Balance")
            .onAppear {
                viewModel.loadBalanceData(modelContext: modelContext, partners: partners)
            }
        }
    }

    private var fairnessGauge: some View {
        VStack(spacing: 16) {
            BalanceGauge(score: viewModel.fairnessScore, size: 140)

            Text(viewModel.balanceStatus.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            HStack(spacing: 20) {
                if partners.count >= 2 {
                    PartnerBreakdownCard(partner: partners[0], breakdown: viewModel.partner1Breakdown)
                    PartnerBreakdownCard(partner: partners[1], breakdown: viewModel.partner2Breakdown)
                }
            }
        }
        .padding()
        .cardStyle()
    }

    private var ownershipBreakdown: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Ownership Breakdown")
                .font(.headline)

            Text("Conception (thinking) + Initiation (starting) + Execution (doing)")
                .font(.caption)
                .foregroundColor(.secondary)

            if partners.count >= 2 {
                OwnershipBar(label: "Conception (Mental Load)", p1: viewModel.partner1Breakdown.conception, p2: viewModel.partner2Breakdown.conception, partners: partners)
                OwnershipBar(label: "Initiation (Starting)", p1: viewModel.partner1Breakdown.initiation, p2: viewModel.partner2Breakdown.initiation, partners: partners)
                OwnershipBar(label: "Execution (Doing)", p1: viewModel.partner1Breakdown.execution, p2: viewModel.partner2Breakdown.execution, partners: partners)
            }
        }
        .padding()
        .cardStyle()
    }

    private var insightsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.amber)
                Text("Pattern Radar")
                    .font(.headline)
            }

            if viewModel.insights.isEmpty {
                Text("No imbalances detected yet. Keep logging tasks!")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                ForEach(viewModel.insights, id: \.title) { insight in
                    InsightCard(insight: insight)
                }
            }
        }
        .padding()
        .cardStyle()
    }
}

struct PartnerBreakdownCard: View {
    let partner: Partner
    let breakdown: (conception: Double, initiation: Double, execution: Double)

    var total: Double {
        breakdown.conception + breakdown.initiation + breakdown.execution
    }

    var body: some View {
        VStack(spacing: 8) {
            PartnerBadge(partner: partner, size: 36)
            Text(partner.name)
                .font(.caption)
                .fontWeight(.medium)

            EffortBadge(score: total)

            VStack(alignment: .leading, spacing: 4) {
                Label(String(format: "Think: %.0f", breakdown.conception), systemImage: "brain")
                    .font(.caption2)
                Label(String(format: "Start: %.0f", breakdown.initiation), systemImage: "play")
                    .font(.caption2)
                Label(String(format: "Do: %.0f", breakdown.execution), systemImage: "hand.raised")
                    .font(.caption2)
            }
            .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

struct OwnershipBar: View {
    let label: String
    let p1: Double
    let p2: Double
    let partners: [Partner]

    var total: Double { p1 + p2 }
    var p1Ratio: CGFloat { total > 0 ? CGFloat(p1 / total) : 0.5 }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)

            GeometryReader { geo in
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.partnerCoral)
                        .frame(width: geo.size.width * p1Ratio)

                    Rectangle()
                        .fill(Color.partnerTeal)
                        .frame(width: geo.size.width * (1 - p1Ratio))
                }
                .cornerRadius(4)
            }
            .frame(height: 8)

            HStack {
                Text(partners.count >= 1 ? "\(partners[0].name): \(String(format: "%.0f", p1))" : "")
                    .font(.caption2)
                    .foregroundColor(.partnerCoral)
                Spacer()
                Text(partners.count >= 2 ? "\(partners[1].name): \(String(format: "%.0f", p2))" : "")
                    .font(.caption2)
                    .foregroundColor(.partnerTeal)
            }
        }
    }
}

struct InsightCard: View {
    let insight: PatternRadarAnalyzer.Insight

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(insight.severity.emoji)
                Text(insight.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }

            Text(insight.description)
                .font(.caption)
                .foregroundColor(.secondary)

            if !insight.suggestedCards.isEmpty {
                Text("Consider shifting: \(insight.suggestedCards.joined(separator: ", "))")
                    .font(.caption)
                    .foregroundColor(.sageGreen)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}
