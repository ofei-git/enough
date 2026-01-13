import SwiftUI
import SwiftData
import UniformTypeIdentifiers

struct ImportView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var isDragging = false
    @State private var selectedFile: URL?
    @State private var importState: ImportState = .ready

    enum ImportState {
        case ready
        case parsing
        case preview(transactions: [ParsedTransaction])
        case importing
        case complete(count: Int)
        case error(message: String)
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            header

            // Content
            content
        }
        .frame(width: 560, height: 480)
        .background(Color.enoughCanvas)
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Import Transactions")
                    .font(.displaySmall)
                    .foregroundColor(.textPrimary)

                Text("Drop a CSV file from your bank")
                    .font(.body)
                    .foregroundColor(.textTertiary)
            }

            Spacer()

            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.textTertiary)
                    .frame(width: 28, height: 28)
                    .background(Color.hoverBackground)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
        }
        .padding(24)
        .background(Color.enoughSurface)
    }

    @ViewBuilder
    private var content: some View {
        switch importState {
        case .ready:
            dropZone
        case .parsing:
            parsingView
        case .preview(let transactions):
            previewView(transactions: transactions)
        case .importing:
            importingView
        case .complete(let count):
            completeView(count: count)
        case .error(let message):
            errorView(message: message)
        }
    }

    private var dropZone: some View {
        VStack(spacing: 24) {
            ZStack {
                RoundedRectangle(cornerRadius: Radius.xl)
                    .strokeBorder(
                        isDragging ? Color.sage400 : Color.borderDefault,
                        style: StrokeStyle(lineWidth: 2, dash: [8, 4])
                    )
                    .background(
                        RoundedRectangle(cornerRadius: Radius.xl)
                            .fill(isDragging ? Color.sage50 : Color.enoughSurface)
                    )

                VStack(spacing: 16) {
                    Image(systemName: "arrow.down.doc")
                        .font(.system(size: 48, weight: .light))
                        .foregroundColor(isDragging ? .sage400 : .textMuted)

                    VStack(spacing: 4) {
                        Text("Drop your CSV here")
                            .font(.headingMedium)
                            .foregroundColor(.textPrimary)

                        Text("or click to browse")
                            .font(.bodySmall)
                            .foregroundColor(.textTertiary)
                    }
                }
            }
            .frame(height: 240)
            .onDrop(of: [.fileURL], isTargeted: $isDragging) { providers in
                handleDrop(providers: providers)
            }
            .onTapGesture {
                selectFile()
            }

            // Supported banks
            VStack(spacing: 8) {
                Text("Supported banks")
                    .font(.caption)
                    .foregroundColor(.textMuted)

                HStack(spacing: 12) {
                    ForEach(["ING", "CBA", "ANZ", "Westpac", "NAB", "Up"], id: \.self) { bank in
                        Text(bank)
                            .font(.caption)
                            .foregroundColor(.textTertiary)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(
                                RoundedRectangle(cornerRadius: Radius.sm)
                                    .fill(Color.enoughSurface)
                            )
                    }
                }
            }
        }
        .padding(24)
    }

    private var parsingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)

            Text("Parsing transactions...")
                .font(.body)
                .foregroundColor(.textSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func previewView(transactions: [ParsedTransaction]) -> some View {
        VStack(spacing: 0) {
            // Stats
            HStack(spacing: 32) {
                statItem(value: "\(transactions.count)", label: "Transactions")
                statItem(
                    value: formatCurrency(transactions.reduce(0) { $0 + abs($1.amount) }),
                    label: "Total Amount"
                )
            }
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(Color.enoughSurface)

            Divider()

            // Preview list
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(transactions.prefix(10), id: \.id) { tx in
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(tx.description)
                                    .font(.bodySmall)
                                    .foregroundColor(.textPrimary)
                                    .lineLimit(1)

                                Text(tx.date.formatted(date: .abbreviated, time: .omitted))
                                    .font(.caption)
                                    .foregroundColor(.textTertiary)
                            }

                            Spacer()

                            Text(formatCurrency(tx.amount))
                                .font(.monoSmall)
                                .foregroundColor(tx.amount < 0 ? .textPrimary : .sage500)
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)

                        Divider()
                    }

                    if transactions.count > 10 {
                        Text("+ \(transactions.count - 10) more transactions")
                            .font(.caption)
                            .foregroundColor(.textTertiary)
                            .padding(.vertical, 16)
                    }
                }
            }

            Divider()

            // Actions
            HStack {
                Button("Cancel") {
                    importState = .ready
                }
                .buttonStyle(.plain)
                .foregroundColor(.textSecondary)

                Spacer()

                Button {
                    performImport(transactions: transactions)
                } label: {
                    Text("Import \(transactions.count) Transactions")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.sage400)
                        .clipShape(RoundedRectangle(cornerRadius: Radius.md))
                }
                .buttonStyle(.plain)
            }
            .padding(24)
        }
    }

    private var importingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)

            Text("Importing transactions...")
                .font(.body)
                .foregroundColor(.textSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func completeView(count: Int) -> some View {
        VStack(spacing: 24) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 64))
                .foregroundColor(.sage400)

            VStack(spacing: 8) {
                Text("Import Complete")
                    .font(.headingLarge)
                    .foregroundColor(.textPrimary)

                Text("\(count) transactions imported successfully")
                    .font(.body)
                    .foregroundColor(.textSecondary)
            }

            Button {
                dismiss()
            } label: {
                Text("Done")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .background(Color.sage400)
                    .clipShape(RoundedRectangle(cornerRadius: Radius.md))
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func errorView(message: String) -> some View {
        VStack(spacing: 24) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 48))
                .foregroundColor(.warm500)

            VStack(spacing: 8) {
                Text("Import Error")
                    .font(.headingLarge)
                    .foregroundColor(.textPrimary)

                Text(message)
                    .font(.body)
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
            }

            Button {
                importState = .ready
            } label: {
                Text("Try Again")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.sage400)
            }
            .buttonStyle(.plain)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func statItem(value: String, label: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.displaySmall)
                .foregroundColor(.textPrimary)

            Text(label)
                .font(.caption)
                .foregroundColor(.textTertiary)
                .textCase(.uppercase)
        }
    }

    // MARK: - Actions

    private func handleDrop(providers: [NSItemProvider]) -> Bool {
        guard let provider = providers.first else { return false }

        provider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { item, error in
            guard let data = item as? Data,
                  let url = URL(dataRepresentation: data, relativeTo: nil) else {
                return
            }

            DispatchQueue.main.async {
                self.selectedFile = url
                self.parseFile(url: url)
            }
        }

        return true
    }

    private func selectFile() {
        let panel = NSOpenPanel()
        panel.allowedContentTypes = [.commaSeparatedText]
        panel.allowsMultipleSelection = false

        if panel.runModal() == .OK, let url = panel.url {
            selectedFile = url
            parseFile(url: url)
        }
    }

    private func parseFile(url: URL) {
        importState = .parsing

        // TODO: Implement actual CSV parsing
        // For now, simulate with delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Simulated parsed transactions
            let sampleTransactions = [
                ParsedTransaction(date: Date(), description: "COLES SUPERMARKET", amount: -127.45),
                ParsedTransaction(date: Date(), description: "FRANKIE'S COFFEE", amount: -8.50),
                ParsedTransaction(date: Date().addingTimeInterval(-86400), description: "BP SERVICE STATION", amount: -89.30),
                ParsedTransaction(date: Date().addingTimeInterval(-86400 * 2), description: "NETFLIX.COM", amount: -22.99),
            ]

            self.importState = .preview(transactions: sampleTransactions)
        }
    }

    private func performImport(transactions: [ParsedTransaction]) {
        importState = .importing

        // TODO: Implement actual import to SwiftData
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.importState = .complete(count: transactions.count)
        }
    }

    private func formatCurrency(_ amount: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "AUD"
        return formatter.string(from: amount as NSDecimalNumber) ?? "$0.00"
    }
}

// MARK: - Parsed Transaction

struct ParsedTransaction: Identifiable {
    let id = UUID()
    let date: Date
    let description: String
    let amount: Decimal
}

#Preview {
    ImportView()
}
