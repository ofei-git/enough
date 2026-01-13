import SwiftUI
import SwiftData

@main
struct EnoughApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Account.self,
            Transaction.self,
            Merchant.self,
            Category.self,
            AppSettings.self
        ])

        // CloudKit sync disabled until Apple Developer account is set up
        // Change to .automatic when ready for iCloud sync
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false,
            cloudKitDatabase: .none
        )

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])

            // Seed default categories if needed
            Task { @MainActor in
                await seedDefaultDataIfNeeded(container: container)
            }

            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(
                    minWidth: Layout.minWindowWidth,
                    minHeight: Layout.minWindowHeight
                )
        }
        .modelContainer(sharedModelContainer)
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentMinSize)
        .commands {
            CommandGroup(replacing: .newItem) { }

            CommandGroup(after: .newItem) {
                Button("Import Transactions...") {
                    NotificationCenter.default.post(name: .showImport, object: nil)
                }
                .keyboardShortcut("i", modifiers: .command)
            }
        }

        #if os(macOS)
        Settings {
            AppSettingsView()
        }
        #endif
    }
}

// MARK: - Seed Default Data

@MainActor
private func seedDefaultDataIfNeeded(container: ModelContainer) async {
    let context = container.mainContext

    // Check if categories already exist
    let descriptor = FetchDescriptor<Category>()
    let existingCategories = (try? context.fetch(descriptor)) ?? []

    guard existingCategories.isEmpty else { return }

    // Seed default categories
    let defaultCategories = Category.defaults
    for category in defaultCategories {
        context.insert(category)
    }

    // Seed default settings
    let settings = AppSettings(enoughNumber: 85000, reviewDay: .sunday)
    context.insert(settings)

    try? context.save()
}

// MARK: - Notifications

extension Notification.Name {
    static let showImport = Notification.Name("showImport")
    static let showReview = Notification.Name("showReview")
}

// MARK: - Placeholder Settings View

struct AppSettingsView: View {
    var body: some View {
        Text("Settings")
            .frame(width: 400, height: 300)
    }
}
