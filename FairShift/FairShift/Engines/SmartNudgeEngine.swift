import Foundation
import UserNotifications

struct SmartNudgeEngine {
    struct NudgeTemplates {
        static let selfReminder = [
            "Your {task} might need some attention today",
            "Quick check: is it time for {task}?",
            "{task} is on your radar for today",
            "Just a friendly nudge: {task}",
        ]

        static let partnerNudge = [
            "Hey! I noticed {task} might be coming up. Want me to help?",
            "Just checking — is {task} on your mind? No rush",
            "I was thinking about {task}. Should we tackle it together?",
        ]
    }

    static func generateNudge(task: ChoreTask, owner: Partner, currentUser: Partner, isOverdue: Bool) -> String {
        let isOwnTask = owner.id == currentUser.id

        if isOwnTask {
            let template = NudgeTemplates.selfReminder.randomElement()!
            return template.replacingOccurrences(of: "{task}", with: task.title.lowercased())
        } else {
            if task.ownershipType == .fullOwnership && !isOverdue {
                return ""
            }
            let template = NudgeTemplates.partnerNudge.randomElement()!
            return template.replacingOccurrences(of: "{task}", with: task.title.lowercased())
        }
    }

    static func scheduleNudge(for task: ChoreTask, owner: Partner) {
        guard let nextDue = task.nextDueDate else { return }

        let content = UNMutableNotificationContent()
        content.title = "FairShift"
        content.body = generateNudge(task: task, owner: owner, currentUser: owner, isOverdue: false)
        content.sound = .default
        content.categoryIdentifier = "CHORE_NUDGE"

        let triggerDate = nextDue.addingTimeInterval(-2 * 60 * 60)
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

        let request = UNNotificationRequest(identifier: "chore-\(task.id.uuidString)", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    static func requestNotificationPermission() async -> Bool {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
            return granted
        } catch {
            return false
        }
    }
}
