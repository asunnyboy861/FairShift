import Foundation
import SwiftData

@Model
final class FairPlayCard {
    var id: UUID = UUID()
    var cardID: String = ""
    var title: String = ""
    var cardDescription: String = ""
    var categoryRaw: String = ChoreCategory.kitchen.rawValue
    var isMinimumStandard: Bool = false
    var estimatedMinutesPerWeek: Int = 15
    var mentalLoadLevel: Int = 5
    var isDealt: Bool = false
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
