import Foundation
import UserNotifications

@Observable
final class NotificationManager {
    var isNotificationEnabled = false

    init() {
        checkPermission()
    }

    func checkPermission() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.isNotificationEnabled = settings.authorizationStatus == .authorized
            }
        }
    }

    func requestPermission() async -> Bool {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
            isNotificationEnabled = granted
            return granted
        } catch {
            return false
        }
    }

    func scheduleTaskReminder(title: String, body: String, at date: Date, identifier: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }

    func cancelReminder(identifier: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
