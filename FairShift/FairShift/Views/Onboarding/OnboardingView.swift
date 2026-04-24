import SwiftUI
import SwiftData

struct OnboardingView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var currentStep = 0
    @State private var yourName = ""
    @State private var partnerName = ""
    @State private var yourEmoji = "😊"
    @State private var partnerEmoji = "😎"

    private let steps = [
        OnboardingStep(icon: "scale.3d", title: "Make the Invisible Visible", description: "FairShift tracks not just who does the chores, but who thinks of them, who starts them, and who carries the mental load."),
        OnboardingStep(icon: "rectangle.on.rectangle.angled", title: "Fair Play Cards", description: "Based on Eve Rodsky's methodology, deal 100+ household responsibility cards fairly between partners."),
        OnboardingStep(icon: "brain", title: "Three-Layer Ownership", description: "Conception (who thinks of it) + Initiation (who starts it) + Execution (who does it). Full Ownership means no reminding needed."),
        OnboardingStep(icon: "person.2", title: "Set Up Your Partnership", description: "Add you and your partner to start tracking your household balance."),
    ]

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentStep) {
                ForEach(0..<steps.count, id: \.self) { index in
                    if index < 3 {
                        stepView(steps[index])
                            .tag(index)
                    } else {
                        setupStep
                            .tag(index)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))

            bottomBar
        }
        .background(Color.warmCream)
    }

    private func stepView(_ step: OnboardingStep) -> some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: step.icon)
                .font(.system(size: 64))
                .foregroundColor(.sageGreen)

            Text(step.title)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text(step.description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            Spacer()
        }
        .padding()
    }

    private var setupStep: some View {
        VStack(spacing: 24) {
            Text("Set Up Your Partnership")
                .font(.title2)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    PartnerSetupField(name: $yourName, emoji: $yourEmoji, label: "You", color: .partnerCoral)
                    PartnerSetupField(name: $partnerName, emoji: $partnerEmoji, label: "Partner", color: .partnerTeal)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }

    private var bottomBar: some View {
        HStack {
            if currentStep > 0 {
                Button("Back") {
                    withAnimation { currentStep -= 1 }
                }
                .foregroundColor(.secondary)
            }

            Spacer()

            if currentStep < steps.count - 1 {
                Button("Next") {
                    withAnimation { currentStep += 1 }
                }
                .buttonStyle(.borderedProminent)
                .tint(.sageGreen)
            } else {
                Button("Get Started") {
                    savePartners()
                }
                .buttonStyle(.borderedProminent)
                .tint(.sageGreen)
                .disabled(yourName.isEmpty || partnerName.isEmpty)
            }
        }
        .padding()
    }

    private func savePartners() {
        let you = Partner(name: yourName, colorName: "PartnerCoral", emoji: yourEmoji, isCurrentUser: true)
        let partner = Partner(name: partnerName, colorName: "PartnerTeal", emoji: partnerEmoji, isCurrentUser: false)
        modelContext.insert(you)
        modelContext.insert(partner)
        try? modelContext.save()

        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
    }
}

struct OnboardingStep {
    let icon: String
    let title: String
    let description: String
}

struct PartnerSetupField: View {
    @Binding var name: String
    @Binding var emoji: String
    let label: String
    let color: Color

    private let emojiOptions = ["😊", "😎", "🥰", "💪", "🧑‍💼", "👩‍🍳", "🧹", "✨"]

    var body: some View {
        VStack(spacing: 12) {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)

            Text(emoji)
                .font(.system(size: 40))

            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 4) {
                ForEach(emojiOptions, id: \.self) { option in
                    Button {
                        emoji = option
                    } label: {
                        Text(option)
                            .font(.title3)
                    }
                }
            }
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(16)
    }
}
