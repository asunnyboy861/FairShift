import SwiftUI
import SwiftData

struct DealCardSheet: View {
    let card: FairPlayCard
    let partners: [Partner]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                FairPlayCardView(card: card, onTap: {})

                Text("Who takes this card?")
                    .font(.headline)

                Text("Remember: Full Ownership means conceiving, initiating, AND executing. No reminding needed.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                if partners.count >= 2 {
                    HStack(spacing: 20) {
                        ForEach(partners) { partner in
                            Button {
                                dealTo(partner)
                            } label: {
                                VStack(spacing: 12) {
                                    PartnerBadge(partner: partner, size: 56)
                                    Text(partner.name)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(partner.colorName == "PartnerCoral" ? Color.partnerCoral.opacity(0.1) : Color.partnerTeal.opacity(0.1))
                                .cornerRadius(16)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                Button("Skip for now") {
                    dismiss()
                }
                .foregroundColor(.secondary)

                Spacer()
            }
            .padding()
            .navigationTitle("Deal Card")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }

    private func dealTo(_ partner: Partner) {
        let viewModel = CardDeckViewModel()
        viewModel.dealCard(card, to: partner, modelContext: modelContext)
        dismiss()
    }
}
