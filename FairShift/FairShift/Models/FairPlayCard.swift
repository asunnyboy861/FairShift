import Foundation
import SwiftData

@Model
final class FairPlayCard {
    @Attribute(.unique) var id: UUID
    var cardID: String
    var title: String
    var cardDescription: String
    var categoryRaw: String
    var isMinimumStandard: Bool
    var estimatedMinutesPerWeek: Int
    var mentalLoadLevel: Int
    var isDealt: Bool
    var assignedPartnerID: UUID?

    var category: ChoreCategory {
        get { ChoreCategory(rawValue: categoryRaw) ?? .kitchen }
        set { categoryRaw = newValue.rawValue }
    }

    init(cardID: String, title: String, category: ChoreCategory) {
        self.id = UUID()
        self.cardID = cardID
        self.title = title
        self.cardDescription = ""
        self.categoryRaw = category.rawValue
        self.isMinimumStandard = false
        self.estimatedMinutesPerWeek = 15
        self.mentalLoadLevel = 5
        self.isDealt = false
    }
}
