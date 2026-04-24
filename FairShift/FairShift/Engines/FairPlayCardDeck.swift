import Foundation

struct FairPlayCardDeck {
    static func generateDeck() -> [FairPlayCard] {
        var cards: [FairPlayCard] = []

        cards += makeCards(category: .kitchen, items: [
            ("Meal Planning", "Plan weekly meals, consider preferences and dietary needs", false, 60, 8),
            ("Grocery Shopping", "Remember what's needed, make lists, go to store", true, 90, 6),
            ("Cooking Dinner", "Prepare evening meals", true, 60, 3),
            ("Cooking Breakfast/Lunch", "Prepare morning and midday meals", false, 45, 3),
            ("Dishwashing", "Load/unload dishwasher, hand-wash items", true, 20, 2),
            ("Counter & Stove Cleaning", "Wipe down surfaces after cooking", true, 10, 2),
            ("Pantry Organization", "Track what's running low, organize storage", false, 15, 6),
            ("Trash & Recycling", "Take out trash, sort recycling, remember pickup days", true, 10, 5),
        ])

        cards += makeCards(category: .bathroom, items: [
            ("Toilet Cleaning", "Scrub toilet, replace cleaning supplies when low", true, 10, 2),
            ("Shower/Tub Cleaning", "Scrub shower/tub, track when due", false, 20, 2),
            ("Mirror & Counter", "Wipe mirrors, organize products", true, 10, 2),
            ("Towel & Linen Changes", "Remember to swap towels, wash bathroom linens", false, 10, 5),
            ("Bathroom Supply Tracking", "Notice when TP, soap, shampoo running low and replace", false, 5, 7),
        ])

        cards += makeCards(category: .grocery, items: [
            ("Shopping List Management", "Maintain ongoing list, remember what's needed", true, 15, 8),
            ("Household Supply Tracking", "Track paper towels, detergent, etc.", false, 10, 7),
            ("Online Ordering", "Place orders for delivery/pickup", false, 30, 4),
            ("Cost Comparison", "Compare prices, find deals, use coupons", false, 20, 3),
        ])

        cards += makeCards(category: .laundry, items: [
            ("Laundry Sorting & Washing", "Sort clothes, run washer, track cycles", true, 30, 4),
            ("Drying & Folding", "Move to dryer, fold, put away", true, 30, 2),
            ("Dry Cleaning Drop-off", "Remember to pick up/drop off dry cleaning", false, 15, 6),
            ("Stain Treatment", "Notice stains, pre-treat before washing", false, 5, 5),
        ])

        cards += makeCards(category: .maintenance, items: [
            ("HVAC Filter Changes", "Remember schedule, purchase filters, replace", false, 15, 7),
            ("Smoke Detector Batteries", "Test monthly, replace batteries annually", false, 10, 6),
            ("Seasonal Prep", "Winterize/summerize home, check systems", false, 60, 6),
            ("Repair Coordination", "Find contractors, schedule, oversee repairs", false, 30, 8),
            ("Car Maintenance", "Track oil changes, inspections, registrations", false, 30, 7),
        ])

        cards += makeCards(category: .pets, items: [
            ("Feeding Schedule", "Remember feeding times, track food supply", true, 10, 6),
            ("Vet Appointments", "Schedule, remember, transport to vet", false, 30, 7),
            ("Medication Tracking", "Remember pet meds, schedule refills", false, 10, 7),
            ("Walking/Exercise", "Daily walks, play time", true, 30, 3),
        ])

        cards += makeCards(category: .kids, items: [
            ("School Communication", "Read emails, respond to teachers, track deadlines", false, 30, 8),
            ("Activity Sign-ups", "Register for activities, track schedules", false, 20, 7),
            ("Homework Help", "Monitor homework, provide assistance", true, 45, 5),
            ("Doctor Appointments", "Schedule, remember, attend well/sick visits", false, 30, 7),
            ("Clothing Inventory", "Track sizes needed, seasonal shopping", false, 20, 6),
        ])

        cards += makeCards(category: .finance, items: [
            ("Bill Payment", "Track due dates, pay bills on time", true, 20, 7),
            ("Budget Management", "Track spending, plan savings", false, 30, 5),
            ("Tax Preparation", "Gather documents, track deductible expenses", false, 60, 7),
            ("Insurance Management", "Review policies, track renewals", false, 30, 5),
        ])

        cards += makeCards(category: .social, items: [
            ("Birthday/Gift Remembering", "Track dates, purchase gifts, send cards", false, 15, 8),
            ("Social Calendar", "Maintain family social calendar, RSVP to events", false, 15, 6),
            ("Holiday Planning", "Plan celebrations, travel, gifts", false, 120, 8),
            ("Family Communication", "Coordinate with extended family, share updates", false, 15, 5),
        ])

        cards += makeCards(category: .health, items: [
            ("Medication Management", "Track all family meds, schedule refills", true, 15, 7),
            ("Appointment Scheduling", "Book and remember all medical appointments", false, 20, 7),
            ("Health Insurance Claims", "File claims, track reimbursements", false, 20, 5),
            ("Family Health Records", "Maintain vaccination records, medical history", false, 15, 6),
        ])

        cards += makeCards(category: .invisible, items: [
            ("Household Anticipation", "NOTICING what needs doing before it becomes urgent", true, 10, 9),
            ("Mental Inventory", "TRACKING supplies, schedules, needs in your head", true, 10, 9),
            ("Worry Work", "Concern for family wellbeing, safety, future planning", false, 30, 9),
            ("Emotional Labor", "Managing family moods, mediating conflicts, providing comfort", true, 30, 9),
            ("Information Management", "Remembering who needs what, when, where", true, 15, 8),
            ("Delegation Management", "Deciding who should do what, following up", true, 15, 8),
            ("Standard Setting", "Defining what 'clean' or 'done' means for each task", false, 10, 7),
            ("Research & Decision Making", "Finding contractors, comparing products, making choices", false, 30, 7),
        ])

        return cards
    }

    private static func makeCards(category: ChoreCategory, items: [(String, String, Bool, Int, Int)]) -> [FairPlayCard] {
        items.enumerated().map { index, item in
            let card = FairPlayCard(
                cardID: "FP-\(category.rawValue)-\(String(format: "%02d", index + 1))",
                title: item.0,
                category: category
            )
            card.cardDescription = item.1
            card.isMinimumStandard = item.2
            card.estimatedMinutesPerWeek = item.3
            card.mentalLoadLevel = item.4
            return card
        }
    }
}
