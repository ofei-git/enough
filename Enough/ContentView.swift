import SwiftUI
import SwiftData

enum NavigationDestination: Hashable {
    case overview
    case transactions
    case trends
}

struct ContentView: View {
    @State private var selectedDestination: NavigationDestination = .overview
    @State private var showingImport = false

    var body: some View {
        HStack(spacing: 0) {
            // Sidebar
            Sidebar(selectedDestination: $selectedDestination)
                .frame(width: Layout.sidebarWidth)

            // Main content
            mainContent
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.enoughCanvas)
        }
        .background(Color.enoughSidebar)
        .sheet(isPresented: $showingImport) {
            ImportView()
        }
        .onReceive(NotificationCenter.default.publisher(for: .showImport)) { _ in
            showingImport = true
        }
    }

    @ViewBuilder
    private var mainContent: some View {
        switch selectedDestination {
        case .overview:
            DashboardView()
        case .transactions:
            TransactionsListView()
        case .trends:
            TrendsView()
        }
    }
}

// MARK: - Placeholder Views

struct TransactionsListView: View {
    var body: some View {
        VStack {
            Text("Transactions")
                .font(.displayTitle)
                .foregroundColor(.textPrimary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct TrendsView: View {
    var body: some View {
        VStack {
            Text("Trends")
                .font(.displayTitle)
                .foregroundColor(.textPrimary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Account.self, Transaction.self, Category.self, AppSettings.self], inMemory: true)
}
