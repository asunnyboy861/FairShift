import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @Query(sort: \Partner.createdAt) private var partners: [Partner]
    @State private var selectedTab = 0

    var body: some View {
        if !hasCompletedOnboarding || partners.count < 2 {
            OnboardingView()
        } else {
            mainTabView
        }
    }

    private var mainTabView: some View {
        TabView(selection: $selectedTab) {
            TodayView()
                .tabItem {
                    Label("Today", systemImage: "sun.max")
                }
                .tag(0)

            CardDeckView()
                .tabItem {
                    Label("Cards", systemImage: "rectangle.on.rectangle.angled")
                }
                .tag(1)

            BalanceView()
                .tabItem {
                    Label("Balance", systemImage: "scale.3d")
                }
                .tag(2)

            LogView()
                .tabItem {
                    Label("Log", systemImage: "checkmark.circle")
                }
                .tag(3)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(4)
        }
        .tint(.sageGreen)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Partner.self, ChoreTask.self, TaskCompletion.self, FairPlayCard.self])
}
