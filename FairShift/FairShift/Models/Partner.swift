import Foundation
import SwiftData

@Model
final class Partner {
    @Attribute(.unique) var id: UUID
    var name: String
    var colorName: String
    var emoji: String
    var isCurrentUser: Bool
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \ChoreTask.conceptionOwner)
    var conceivedTasks: [ChoreTask] = []

    @Relationship(deleteRule: .cascade, inverse: \ChoreTask.initiationOwner)
    var initiatedTasks: [ChoreTask] = []

    @Relationship(deleteRule: .cascade, inverse: \ChoreTask.executionOwner)
    var executedTasks: [ChoreTask] = []

    init(name: String, colorName: String = "PartnerCoral", emoji: String = "😊", isCurrentUser: Bool = false) {
        self.id = UUID()
        self.name = name
        self.colorName = colorName
        self.emoji = emoji
        self.isCurrentUser = isCurrentUser
        self.createdAt = Date()
    }
}
