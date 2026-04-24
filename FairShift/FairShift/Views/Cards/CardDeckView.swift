import SwiftUI
import SwiftData

struct CardDeckView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Partner.createdAt) private var partners: [Partner]
    @State private var viewModel = CardDeckViewModel()
    @State private var showingDealSheet = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    deckProgress

                    categoryFilter

                    if viewModel.undealtCards.isEmpty && viewModel.dealtCards.isEmpty {
                        EmptyStateView(
                            icon: "rectangle.on.rectangle.angled",
                            title: "No Cards Yet",
                            subtitle: "Pull down to load the Fair Play card deck"
                        )
                    } else {
                        undealtSection
                        if !viewModel.dealtCards.isEmpty {
                            dealtSection
                        }
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Fair Play Cards")
            .refreshable {
                viewModel.loadCards(modelContext: modelContext)
            }
            .onAppear {
                viewModel.loadCards(modelContext: modelContext)
            }
        }
    }

    private var deckProgress: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Card Deck Progress")
                    .font(.headline)
                Spacer()
                Text("\(viewModel.dealtCards.count)/\(viewModel.allCards.count)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            ProgressView(value: Double(viewModel.dealtCards.count), total: Double(viewModel.allCards.count))
                .tint(.sageGreen)

            if partners.count >= 2 {
                HStack(spacing: 16) {
                    DealCountBadge(partner: partners[0], count: viewModel.dealCount(for: partners[0]))
                    DealCountBadge(partner: partners[1], count: viewModel.dealCount(for: partners[1]))
                }
            }
        }
        .padding()
        .cardStyle()
    }

    private var categoryFilter: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                CategoryFilterChip(category: nil, isSelected: viewModel.selectedCategory == nil) {
                    viewModel.selectedCategory = nil
                }

                ForEach(ChoreCategory.allCases, id: \.self) { cat in
                    CategoryFilterChip(category: cat, isSelected: viewModel.selectedCategory == cat) {
                        viewModel.selectedCategory = cat
                    }
                }
            }
        }
    }

    private var undealtSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Undealt Cards")
                .font(.headline)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(viewModel.filteredCards()) { card in
                    FairPlayCardView(card: card) {
                        viewModel.selectedCard = card
                        showingDealSheet = true
                    }
                }
            }
        }
    }

    private var dealtSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Dealt Cards")
                .font(.headline)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(viewModel.dealtCards) { card in
                    FairPlayCardView(card: card, isDealt: true) { }
                        .opacity(0.6)
                }
            }
        }
    }
}

struct CategoryFilterChip: View {
    let category: ChoreCategory?
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                if let cat = category {
                    Image(systemName: cat.icon)
                        .font(.caption)
                }
                Text(category?.rawValue ?? "All")
                    .font(.caption)
                    .fontWeight(isSelected ? .semibold : .regular)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(isSelected ? Color.sageGreen : Color(.secondarySystemBackground))
            .foregroundColor(isSelected ? .white : .primary)
            .cornerRadius(20)
        }
    }
}

struct DealCountBadge: View {
    let partner: Partner
    let count: Int

    var body: some View {
        HStack(spacing: 6) {
            PartnerBadge(partner: partner, size: 24)
            Text("\(count) cards")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }
}

struct FairPlayCardView: View {
    let card: FairPlayCard
    var isDealt: Bool = false
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    CategoryIcon(category: card.category, size: 16)
                    Spacer()
                    if card.isMinimumStandard {
                        Image(systemName: "star.fill")
                            .font(.caption2)
                            .foregroundColor(.amber)
                    }
                }

                Text(card.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .lineLimit(2)

                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.caption2)
                    Text("\(card.estimatedMinutesPerWeek)m/wk")
                        .font(.caption2)
                }
                .foregroundColor(.secondary)

                HStack(spacing: 4) {
                    Image(systemName: "brain")
                        .font(.caption2)
                    Text("ML: \(card.mentalLoadLevel)")
                        .font(.caption2)
                }
                .foregroundColor(card.mentalLoadLevel >= 7 ? .partnerCoral : .secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(isDealt ? Color(.systemBackground) : Color.warmCream)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.06), radius: 4, y: 2)
        }
        .buttonStyle(.plain)
    }
}
