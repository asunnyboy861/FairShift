import SwiftUI
import SwiftData

@Observable
final class SettingsViewModel {
    var partners: [Partner] = []
    var showingAddPartner = false
    var showingPaywall = false
    var isPro = false

    func loadPartners(modelContext: ModelContext) {
        let descriptor = FetchDescriptor<Partner>(sortBy: [SortDescriptor(\.createdAt)])

        do {
            partners = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to load partners: \(error)")
        }
    }

    func addPartner(name: String, emoji: String, colorName: String, isCurrentUser: Bool, modelContext: ModelContext) {
        let partner = Partner(name: name, colorName: colorName, emoji: emoji, isCurrentUser: isCurrentUser)
        modelContext.insert(partner)
        try? modelContext.save()
        partners.append(partner)
    }

    func deletePartner(_ partner: Partner, modelContext: ModelContext) {
        modelContext.delete(partner)
        try? modelContext.save()
        partners.removeAll { $0.id == partner.id }
    }

    var currentUser: Partner? {
        partners.first { $0.isCurrentUser }
    }

    var otherPartner: Partner? {
        partners.first { !$0.isCurrentUser }
    }
}
