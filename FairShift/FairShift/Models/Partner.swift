import Foundation
import SwiftData

@Model
final class Partner {
    var id: UUID = UUID()
    var name: String = ""
    var colorName: String = "PartnerCoral"
    var emoji: String = "😊"
    var isCurrentUser: Bool = false
    var createdAt: Date = Date()

    @Relationship(deleteRule: .cascade, inverse: \ChoreTask.conceptionOwner)
    var conceivedTasks: [ChoreTask]?

    @Relationship(deleteRule: .cascade, inverse: \ChoreTask.initiationOwner)
    var initiatedTasks: [ChoreTask]?

    @Relationship(deleteRule: .cascade, inverse: \ChoreTask.executionOwner)
    var executedTasks: [ChoreTask]?

    init(name: String, colorName: String = "PartnerCoral", emoji: String = "😊", isCurrentUser: Bool = false) {
        self.id = UUID()
        self.name = name
        self.colorName = colorName
        self.emoji = emoji
        self.isCurrentUser = isCurrentUser
        self.createdAt = Date()
        self.conceivedTasks = []
        self.initiatedTasks = []
        self.executedTasks = []
    }
}
