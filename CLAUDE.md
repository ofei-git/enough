# Enough - Development Context

## Project Overview
A spending awareness Mac app (SwiftUI, macOS 14+) with a "sage & cream" design aesthetic. Local-first with SwiftData, CloudKit sync planned for later.

## Current State (January 2026)

### Completed
- **Design System**: Colors, typography (Source Serif 4 + SF Pro), shadows, spacing
- **Core Components**: ProgressRing, CategoryIcon, CardView, NavItem, TransactionRow
- **Data Models**: Account, Transaction, Merchant, Category, AppSettings (SwiftData)
- **Dashboard**: EnoughMeterCard with progress ring, category grid, recent transactions
- **Sidebar**: Navigation, accounts list, enough badge
- **Import View**: UI complete (drag-drop, preview) but parsing is stubbed
- **Font Loading**: Source Serif 4 bundled and loading correctly
- **Max Content Width**: 860px constraint for elegant full-screen appearance

### Typography Reference
All display fonts use Source Serif 4 **Light (300)** for an elegant, refined feel.

| Element | Size | Weight |
|---------|------|--------|
| Main amount | 64px | Light |
| Page title | 40px | Light |
| Display medium | 36px | Light |
| Category amount | 26px | Light |
| Sidebar badge | 22px | Light |

## Next Priority: CSV Import

The import flow UI exists but needs real implementation:

1. **CSV Parser** (`Services/CSVParser.swift`)
   - Parse CSV files into structured data
   - Handle different column orders and formats

2. **Bank Format Detection** (`Services/BankFormatDetector.swift`)
   - Auto-detect bank from CSV headers
   - Support: ING, CBA, ANZ, Westpac, NAB, Up, Macquarie

3. **Transaction Import**
   - Save parsed transactions to SwiftData
   - Link to accounts
   - Duplicate detection (date + amount + description)

4. **Merchant Memory**
   - Auto-categorize known merchants
   - Queue unknown transactions for review

## Future Priorities

1. **Weekly Review Flow** - Categorization UI is designed but not wired up
2. **Onboarding** - Enough number discovery flow
3. **CloudKit Sync** - Waiting on Apple Developer account approval
4. **Trends View** - Spending over time visualization

## Key Files

- `Enough/EnoughApp.swift` - App entry, ModelContainer setup
- `Enough/Design/` - Colors, Typography, Shadows, Spacing
- `Enough/Models/` - SwiftData models
- `Enough/Views/Dashboard/` - Main dashboard components
- `Enough/Views/Import/ImportView.swift` - Import UI (needs backend)
- `Mockups/enough-refined.html` - Design reference (sage palette)

## Technical Notes

- **CloudKit**: Currently disabled (`cloudKitDatabase: .none`). Change to `.automatic` when ready.
- **Fonts**: Registered via `FontRegistration.registerFonts()` in app init
- **Entitlements**: Sandbox enabled, file access for CSV import

## Repository
https://github.com/ofei-git/enough
