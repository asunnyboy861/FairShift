import Foundation

struct PatternRadarAnalyzer {
    struct WeeklyPattern {
        let dayOfWeek: Int
        let partner1Load: Double
        let partner2Load: Double
    }

    struct Insight {
        let title: String
        let description: String
        let suggestedCards: [String]
        let severity: BalanceStatus
    }

    static func analyzeWeeklyPattern(completions: [TaskCompletion], partners: [Partner]) -> [WeeklyPattern] {
        var patterns: [WeeklyPattern] = []
        let calendar = Calendar.current

        for day in 0..<7 {
            var partner1Load: Double = 0
            var partner2Load: Double = 0

            for completion in completions {
                let component = calendar.component(.weekday, from: completion.completedAt)
                if (component - 1) == day {
                    if partners.count >= 2 {
                        if completion.partnerID == partners[0].id {
                            partner1Load += Double(completion.minutesSpent)
                        } else if completion.partnerID == partners[1].id {
                            partner2Load += Double(completion.minutesSpent)
                        }
                    }
                }
            }

            patterns.append(WeeklyPattern(dayOfWeek: day, partner1Load: partner1Load, partner2Load: partner2Load))
        }

        return patterns
    }

    static func generateInsights(tasks: [ChoreTask], partners: [Partner]) -> [Insight] {
        var insights: [Insight] = []

        guard partners.count >= 2 else { return insights }

        let p1 = partners[0]
        let p2 = partners[1]

        let p1Conception = tasks.filter { $0.conceptionOwner?.id == p1.id }.count
        let p2Conception = tasks.filter { $0.conceptionOwner?.id == p2.id }.count
        let p1Invisible = tasks.filter { $0.isInvisible && $0.executionOwner?.id == p1.id }.count
        let p2Invisible = tasks.filter { $0.isInvisible && $0.executionOwner?.id == p2.id }.count

        if p1Conception > p2Conception * 2 {
            let suggestedShifts = tasks.filter { $0.conceptionOwner?.id == p1.id && !$0.isInvisible }.prefix(3).map { $0.title }
            insights.append(Insight(
                title: "\(p1.name) carries most of the mental load",
                description: "\(p1.name) conceives \(p1Conception) tasks vs \(p2.name)'s \(p2Conception). The \"thinking and remembering\" is the core of mental load.",
                suggestedCards: Array(suggestedShifts),
                severity: .needsAttention
            ))
        }

        if p1Invisible > p2Invisible * 2 {
            let suggestedShifts = tasks.filter { $0.isInvisible && $0.executionOwner?.id == p1.id }.prefix(3).map { $0.title }
            insights.append(Insight(
                title: "Invisible work is heavily imbalanced",
                description: "\(p1.name) handles \(p1Invisible) invisible tasks vs \(p2.name)'s \(p2Invisible). These are the tasks nobody sees but everyone feels.",
                suggestedCards: Array(suggestedShifts),
                severity: .needsAttention
            ))
        }

        return insights
    }
}
