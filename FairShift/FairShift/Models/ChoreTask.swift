import Foundation
import SwiftData

@Model
final class ChoreTask {
    @Attribute(.unique) var id: UUID
    var title: String
    var taskDescription: String
    var categoryRaw: String
    var effortWeightRaw: String
    var ownershipTypeRaw: String
    var frequencyRaw: String
    var estimatedMinutes: Int
    var mentalLoadScore: Int
    var isInvisible: Bool
    var createdAt: Date
    var lastCompletedAt: Date?
    var nextDueDate: Date?
    var fairPlayCardID: String?
    var isFromCardDeck: Bool

    var conceptionOwner: Partner?
    var initiationOwner: Partner?
    var executionOwner: Partner?

    @Relationship(deleteRule: .cascade)
    var completions: [TaskCompletion] = []

    var category: ChoreCategory {
        get { ChoreCategory(rawValue: categoryRaw) ?? .kitchen }
        set { categoryRaw = newValue.rawValue }
    }

    var effortWeight: EffortWeight {
        get { EffortWeight(rawValue: effortWeightRaw) ?? .medium }
        set { effortWeightRaw = newValue.rawValue }
    }

    var ownershipType: OwnershipType {
        get { OwnershipType(rawValue: ownershipTypeRaw) ?? .fullOwnership }
        set { ownershipTypeRaw = newValue.rawValue }
    }

    var frequency: TaskFrequency {
        get { TaskFrequency(rawValue: frequencyRaw) ?? .weekly }
        set { frequencyRaw = newValue.rawValue }
    }

    var owner: Partner? {
        executionOwner ?? initiationOwner ?? conceptionOwner
    }

    init(title: String, category: ChoreCategory, isInvisible: Bool = false) {
        self.id = UUID()
        self.title = title
        self.taskDescription = ""
        self.categoryRaw = category.rawValue
        self.effortWeightRaw = EffortWeight.medium.rawValue
        self.ownershipTypeRaw = OwnershipType.fullOwnership.rawValue
        self.frequencyRaw = TaskFrequency.weekly.rawValue
        self.estimatedMinutes = 15
        self.mentalLoadScore = isInvisible ? 7 : 3
        self.isInvisible = isInvisible
        self.createdAt = Date()
        self.completions = []
        self.isFromCardDeck = false
    }
}
