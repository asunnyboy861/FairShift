import SwiftUI

struct PaywallView: View {
    @ObservedObject var purchaseManager: PurchaseManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    headerSection
                    featureComparison
                    pricingOptions
                    legalSection
                }
                .padding()
            }
            .background(Color.warmCream)
            .navigationTitle("FairShift Pro")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }

    private var headerSection: some View {
        VStack(spacing: 12) {
            Image(systemName: "scale.3d")
                .font(.system(size: 48))
                .foregroundColor(.sageGreen)

            Text("Unlock Full Fairness")
                .font(.title2)
                .fontWeight(.bold)

            Text("See the invisible. Share the load. Build a fairer home together.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 20)
    }

    private var featureComparison: some View {
        VStack(alignment: .leading, spacing: 12) {
            FeatureRow(icon: "rectangle.on.rectangle.angled", title: "Full Fair Play Card Deck", subtitle: "100+ cards vs 10 free")
            FeatureRow(icon: "brain", title: "Mental Load Map", subtitle: "Visualize invisible work")
            FeatureRow(icon: "chart.bar", title: "Partnership Score", subtitle: "Deep fairness analytics")
            FeatureRow(icon: "exclamationmark.triangle", title: "Pattern Radar", subtitle: "Detect imbalances early")
            FeatureRow(icon: "bell.badge", title: "Smart Nudge", subtitle: "Non-judgmental reminders")
            FeatureRow(icon: "person.2", title: "Partner Sync", subtitle: "Real-time collaboration")
        }
        .padding()
        .cardStyle()
    }

    private var pricingOptions: some View {
        VStack(spacing: 12) {
            if let monthly = purchaseManager.monthlyProduct {
                PricingCard(
                    title: "Monthly",
                    price: monthly.displayPrice,
                    period: "/month",
                    isPopular: false
                ) {
                    Task { await purchaseManager.purchase(monthly) }
                }
            }

            if let yearly = purchaseManager.yearlyProduct {
                PricingCard(
                    title: "Yearly",
                    price: yearly.displayPrice,
                    period: "/year",
                    subtitle: "Save 48%",
                    isPopular: true
                ) {
                    Task { await purchaseManager.purchase(yearly) }
                }
            }

            if let lifetime = purchaseManager.lifetimeProduct {
                PricingCard(
                    title: "Lifetime",
                    price: lifetime.displayPrice,
                    period: "",
                    subtitle: "One-time purchase",
                    isPopular: false
                ) {
                    Task { await purchaseManager.purchase(lifetime) }
                }
            }
        }
    }

    private var legalSection: some View {
        VStack(spacing: 8) {
            Text("Subscription automatically renews unless canceled at least 24 hours before the end of the current period. Manage or cancel in Settings > Apple ID > Subscriptions.")
                .font(.caption2)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            HStack(spacing: 16) {
                Link("Privacy Policy", destination: URL(string: "https://fairshift.app/privacy")!)
                Link("Terms of Use", destination: URL(string: "https://fairshift.app/terms")!)
            }
            .font(.caption)
            .foregroundColor(.sageGreen)

            Button("Restore Purchases") {
                Task { await purchaseManager.restorePurchases() }
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding(.top, 8)
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.sageGreen)
                .frame(width: 32)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "checkmark")
                .foregroundColor(.sageGreen)
        }
    }
}

struct PricingCard: View {
    let title: String
    let price: String
    let period: String
    var subtitle: String? = nil
    let isPopular: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(title)
                            .font(.headline)
                        if isPopular {
                            Text("Best Value")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 2)
                                .background(Color.sageGreen)
                                .foregroundColor(.white)
                                .cornerRadius(4)
                        }
                    }

                    if let sub = subtitle {
                        Text(sub)
                            .font(.caption)
                            .foregroundColor(.sageGreen)
                    }
                }

                Spacer()

                Text(price)
                    .font(.title2)
                    .fontWeight(.bold)
                + Text(period)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(isPopular ? Color.sageGreen.opacity(0.1) : Color(.systemBackground))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isPopular ? Color.sageGreen : Color(.systemGray4), lineWidth: isPopular ? 2 : 1)
            )
        }
        .buttonStyle(.plain)
    }
}
