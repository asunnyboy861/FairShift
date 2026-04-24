import SwiftUI
import SwiftData

@Observable
final class CardDeckViewModel {
    var allCards: [FairPlayCard] = []
    var undealtCards: [FairPlayCard] = []
    var dealtCards: [FairPlayCard] = []
    var selectedCategory: ChoreCategory?
    var showingDealSheet = false
    var selectedCard: FairPlayCard?

    func loadCards(modelContext: ModelContext) {
        let descriptor = FetchDescriptor<FairPlayCard>(sortBy: [SortDescriptor(\.cardID)])

        do {
            allCards = try modelContext.fetch(descriptor)
            if allCards.isEmpty {
                let deck = FairPlayCardDeck.generateDeck()
                for card in deck {
                    modelContext.insert(card)
                }
                try modelContext.save()
                allCards = deck
            }
            undealtCards = allCards.filter { !$0.isDealt }
            dealtCards = allCards.filter { $0.isDealt }
        } catch {
            print("Failed to load cards: \(error)")
        }
    }

    func filteredCards() -> [FairPlayCard] {
        guard let category = selectedCategory else { return undealtCards }
        return undealtCards.filter { $0.category == category }
    }

    func dealCard(_ card: FairPlayCard, to partner: Partner, modelContext: ModelContext) {
        card.isDealt = true
        card.assignedPartnerID = partner.id

        let task = ChoreTask(title: card.title, category: card.category)
        task.isFromCardDeck = true
        task.fairPlayCardID = card.cardID
        task.mentalLoadScore = card.mentalLoadLevel
        task.estimatedMinutes = card.estimatedMinutesPerWeek
        task.executionOwner = partner
        task.conceptionOwner = partner
        task.initiationOwner = partner

        modelContext.insert(task)
        try? modelContext.save()

        undealtCards.removeAll { $0.id == card.id }
        dealtCards.append(card)
    }

    func dealCount(for partner: Partner) -> Int {
        dealtCards.filter { $0.assignedPartnerID == partner.id }.count
    }
}
