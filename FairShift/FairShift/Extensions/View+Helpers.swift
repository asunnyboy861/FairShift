import SwiftUI

extension View {
    func cardStyle() -> some View {
        self
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.06), radius: 8, y: 2)
    }

    func fairPlayCardStyle() -> some View {
        self
            .background(Color.warmCream)
            .cornerRadius(24)
            .shadow(color: Color.black.opacity(0.1), radius: 12, y: 4)
    }

    func iPadMaxWidth() -> some View {
        self.frame(maxWidth: 720).frame(maxWidth: .infinity)
    }
}
