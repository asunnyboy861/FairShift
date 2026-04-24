import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = SettingsViewModel()
    @State private var purchaseManager = PurchaseManager()
    @State private var showingAddPartner = false
    @State private var showingPaywall = false

    var body: some View {
        NavigationStack {
            List {
                partnerSection
                subscriptionSection
                aboutSection
            }
            .navigationTitle("Settings")
            .onAppear {
                viewModel.loadPartners(modelContext: modelContext)
            }
            .sheet(isPresented: $showingAddPartner) {
                AddPartnerView(viewModel: viewModel)
            }
            .sheet(isPresented: $showingPaywall) {
                PaywallView(purchaseManager: purchaseManager)
            }
        }
    }

    private var partnerSection: some View {
        Section {
            ForEach(viewModel.partners) { partner in
                HStack(spacing: 12) {
                    PartnerBadge(partner: partner, size: 36)
                    VStack(alignment: .leading) {
                        Text(partner.name)
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Text(partner.isCurrentUser ? "You" : "Partner")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
            }

            Button(action: { showingAddPartner = true }) {
                Label("Add Partner", systemImage: "person.badge.plus")
            }
        } header: {
            Text("Partners")
        }
    }

    private var subscriptionSection: some View {
        Section {
            HStack {
                Image(systemName: purchaseManager.isPro ? "crown.fill" : "crown")
                    .foregroundColor(.amber)

                VStack(alignment: .leading) {
                    Text(purchaseManager.isPro ? "FairShift Pro" : "Free Plan")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Text(purchaseManager.isPro ? "All features unlocked" : "Upgrade for full features")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                if !purchaseManager.isPro {
                    Button("Upgrade") {
                        showingPaywall = true
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.sageGreen)
                }
            }

            Button("Restore Purchases") {
                Task { await purchaseManager.restorePurchases() }
            }
        } header: {
            Text("Subscription")
        }
    }

    private var aboutSection: some View {
        Section {
            Link(destination: URL(string: "https://fairshift.app/privacy")!) {
                Label("Privacy Policy", systemImage: "hand.raised")
            }

            Link(destination: URL(string: "https://fairshift.app/terms")!) {
                Label("Terms of Use", systemImage: "doc.text")
            }

            Link(destination: URL(string: "mailto:support@fairshift.app")!) {
                Label("Contact Support", systemImage: "envelope")
            }

            HStack {
                Text("Version")
                Spacer()
                Text("1.0.0")
                    .foregroundColor(.secondary)
            }
        } header: {
            Text("About")
        }
    }
}

struct AddPartnerView: View {
    let viewModel: SettingsViewModel
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var emoji = "😊"
    @State private var isCurrentUser = false
    @State private var colorName = "PartnerCoral"

    private let emojiOptions = ["😊", "😎", "🥰", "💪", "🧑‍💼", "👩‍🍳", "🧹", "✨"]

    var body: some View {
        NavigationStack {
            Form {
                Section("Partner Info") {
                    TextField("Name", text: $name)

                    Toggle("This is me", isOn: $isCurrentUser)
                }

                Section("Avatar") {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 12) {
                        ForEach(emojiOptions, id: \.self) { option in
                            Button {
                                emoji = option
                            } label: {
                                Text(option)
                                    .font(.title)
                                    .frame(width: 44, height: 44)
                                    .background(emoji == option ? Color.sageGreen.opacity(0.2) : Color.clear)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }

                Section("Color") {
                    HStack(spacing: 16) {
                        ColorOptionButton(colorName: "PartnerCoral", displayColor: .partnerCoral, selected: colorName)
                        ColorOptionButton(colorName: "PartnerTeal", displayColor: .partnerTeal, selected: colorName)
                    }
                }
            }
            .navigationTitle("Add Partner")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        viewModel.addPartner(
                            name: name,
                            emoji: emoji,
                            colorName: colorName,
                            isCurrentUser: isCurrentUser,
                            modelContext: modelContext
                        )
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}

struct ColorOptionButton: View {
    let colorName: String
    let displayColor: Color
    let selected: String

    var body: some View {
        Button {
        } label: {
            Circle()
                .fill(displayColor)
                .frame(width: 40, height: 40)
                .overlay(
                    Circle()
                        .stroke(Color.primary, lineWidth: selected == colorName ? 3 : 0)
                )
        }
    }
}
