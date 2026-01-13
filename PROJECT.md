# Enough

## What This Is

A spending awareness app for people who want to understand where their money goes—not optimize, restrict, or gamify it. Built for the Apple ecosystem (Mac + iOS), local-first, with manual import as intentional friction.

The name comes from a philosophy: most financial tools assume you want more. Enough assumes you want clarity about what your life actually costs, so you can make intentional decisions about how to live.

## The Problem

**15 years of failed expense tracking attempts.**

I've tried spreadsheets, Airtable, Notion, Pocketsmith. I have accounting experience. I've used Xero for business since 2014. None of it stuck for personal finances.

The tools fail because they optimize for the wrong thing:
- **Too much automation** — bank syncing means you never actually *see* your spending
- **Too much restriction** — budgets create pass/fail anxiety, leading to frugal fatigue
- **Too much data** — dashboards and charts without insight
- **Too much friction** — categorizing 200 transactions is soul-crushing

What I actually want: **awareness**. Where does the money go? Is it aligned with how I want to live? Am I spending enough on what matters and less on what doesn't?

## The Opportunity

### Market Whitespace

| What Exists | What's Missing |
|-------------|----------------|
| Copilot — beautiful, Apple-native | Requires bank connection, US-only |
| Actual Budget — local-first, privacy-focused | Self-hosted, not native, no design craft |
| YNAB — strong philosophy | Web-based, steep learning curve |
| Everyone else | Cloud-dependent, subscription fatigue, bank sync problems |

**The gap:** A design-forward, local-first, native Apple app with manual entry as a feature and a philosophical angle. No one is there.

### Why Manual Import Works

Research shows manual entry increases financial awareness—the act of seeing each transaction creates mindfulness that automatic syncing destroys. Studies suggest this reduces unnecessary purchases by 10-15%.

Manual isn't a limitation. It's the mechanism for behavior change.

### The "Enough" Philosophy

The FIRE movement's first tenet: "Build the life you want. Then save for it."

Most finance apps serve optimizers—people trying to maximize savings or eliminate debt. Enough serves a different mindset: people who want sufficiency, not maximization. Clarity about what their life costs so they can make intentional choices.

This is underserved territory.

## Core Concepts

### The Enough Number

The enough number is the philosophical heart of the app—where it earns emotional investment or becomes just another tracker.

**What it is:**
The cost of a life that satisfies you. The point where more spending doesn't create more happiness. A number rooted in values, not spreadsheets.

**What it's not:**
- What you currently spend (that's just baseline)
- What you think you "should" spend (arbitrary guilt)
- Income minus savings goal (passive, no meaning)
- A budget (restriction)

**The question it answers:**
Most finance apps ask "What's your budget?" That's a restriction question—it creates anxiety.

The enough number asks something different: **What does the life you want actually cost?**

**The research behind it:**
- **Kahneman's satiation point:** Emotional wellbeing increases with income up to a point, then flattens. More money helps until it doesn't.
- **The hedonic treadmill:** We adapt to higher spending. The happiness boost from upgrades is temporary, then becomes the new baseline.
- **"Your Money or Your Life" (Vicki Robin):** Maps spending to "life energy"—hours of your life traded for money. Forces the question: is this purchase worth X hours?

The insight: enough is discoverable, personal, and not what society tells you it is.

**What the number enables:**

*A mirror, not a judge.* You're not "over budget"—you're over what *you* said was enough for the life *you* want. That's useful information, not failure.

*Permission-giving.* Under your enough number? You have room. Spend on what matters without guilt.

*A hypothesis, not a commitment.* The number can change. After 3 months of data, you might realize your enough is higher or lower. That's learning, not failure.

**The emotional shift:** From "Am I spending too much?" (anxiety) to "Am I aligned with what I said was enough?" (awareness)

### Discovering Your Enough Number (Onboarding)

The onboarding is where users discover their number. Three paths, increasing in depth:

**Quick Path** (for eager users)
"What do you think your household spends in a year? Your best guess is fine—you'll refine it as you learn."

Simple, gets them into the app fast. The number becomes more accurate through actual data.

**Grounded Path** (recommended default)
Walk through major categories:
- **Housing:** What does home cost for a place that feels right?
- **Food:** What does eating well look like for you?
- **Transport:** Getting around the way you need to?
- **Health:** Taking care of yourself?
- **Joy:** Experiences, hobbies, things that bring genuine pleasure?

Sum these up. That's your enough. Connects the number to real life, not abstract math.

**Deep Path** (optional, values-first)
For users who want meaning:
1. What matters most to you? (Family, health, security, creativity, experiences, giving)
2. For each value: What spending enables it?
3. For each value: Where does more spending stop adding value?

Discovers enough through meaning. The number becomes an expression of priorities, not a constraint.

**The emotional journey in onboarding:**
1. **Recognition** — "This app gets that it's not about restriction"
2. **Reflection** — "What *do* I actually need for a good life?"
3. **Clarity** — "I have a number, and it's mine"
4. **Permission** — "If I'm under enough, I can spend without guilt"

**Practical onboarding flow:**
1. Welcome: "Enough helps you see where your money goes—so you can spend on what matters."
2. The question: "What does a good year cost for your household? Not a budget—just the cost of a life that feels right."
3. Optional helper: "Not sure? Let's figure it out together." → category breakdown
4. The commitment: "Your enough number is $X. We'll help you stay aware of how you're tracking."
5. Refinement prompt (later): "After a few months, you might want to adjust this. That's the point—you're learning."

**Don't make it too heavy.** Users want to use the app. But don't make it throwaway either—this is the opportunity to create meaning.

### The Weekly Review

The core ritual. Not daily logging (exhausting). Not monthly reconciliation (too late for awareness). Weekly.

Import your bank CSV. Review new transactions. Categorize the few that aren't auto-recognized. See your week's story.

The design goal: make this feel like a 10-minute ritual you look forward to, not a chore you avoid.

### Awareness, Not Restriction

The app shows you a mirror. Here's where your money went. Here's how it compares to your enough number. Here's the trend.

It doesn't judge. It doesn't suggest "cutting back on coffee." It trusts you to draw your own conclusions from clear data.

### Household View

Personal finance is rarely purely individual. Partners, families, shared expenses. Enough handles this simply:

- Multiple accounts (personal, joint, partner's)
- Everything rolls up to one household view
- Filter by account when needed
- No complex splitting or reconciliation

The unit of analysis is the household, not the individual.

## How It Works

### Import Flow

1. **Export CSV from bank** — most Australian banks support this
2. **Drop into Enough** — drag-and-drop or file picker
3. **Auto-detection** — app recognizes bank format, maps columns
4. **Review inbox** — new transactions appear for categorization

Supported formats: CSV from major Australian banks (ING, CBA, ANZ, Westpac, NAB). Custom format mapping for others.

### Categorization

Three layers, in order:

**1. Merchant Memory**
Once you categorize "COLES SUPERMARKET" as Groceries, every future Coles transaction auto-categorizes. Simple payee → category mapping.

**2. User Rules**
"If description contains 'AMAZON', ask me" (because Amazon could be anything). Created automatically from corrections.

**3. On-Device ML**
Core ML text classifier for new/unknown merchants. Ships with a base model, improves from your corrections. All local, no cloud.

After 2-3 weeks, 90%+ should auto-categorize correctly.

### Categories

Opinionated defaults (~15):

- **Housing** — rent, mortgage, property costs
- **Utilities** — power, water, internet, phone
- **Groceries** — supermarkets, food shopping
- **Dining** — restaurants, cafes, takeaway
- **Transport** — fuel, public transit, car costs
- **Health** — medical, dental, pharmacy, fitness
- **Subscriptions** — recurring digital services
- **Shopping** — general retail, clothing, household
- **Entertainment** — events, streaming, hobbies
- **Travel** — flights, accommodation, holidays
- **Insurance** — health, home, car, life
- **Personal Care** — haircuts, beauty, self-care
- **Gifts** — presents, donations, charity
- **Education** — courses, books, learning
- **Other** — catch-all for the rest

Users can add, remove, rename, or create sub-categories. But the defaults should work for most people immediately.

### The Dashboard

Not a wall of charts. A focused view:

**Primary:** This month vs. your enough number (monthly). A single, clear metric.

**Secondary:** Top 3 categories this month. Where the money actually went.

**Tertiary:** Trend over time. Are you spending more or less than previous months?

The goal is glanceable insight, not comprehensive data. Drill-down available, but the surface is simple.

## Design Philosophy

### Aligned with Ofei Studios

- **Intentional friction** — manual import creates engagement
- **Insight over data** — one meaningful observation beats ten metrics
- **The tool disappears** — if you notice the app, we've failed
- **Beauty invites practice** — sustainable habits need tools you want to return to
- **Opinionated design** — our categories encode values
- **Local-first, privacy by architecture** — your data stays on your device

### The Weekly Ritual

The experience needs to feel like:
- Opening a well-designed journal, not a spreadsheet
- A 10-minute reflection, not an hour of data entry
- Progress and clarity, not judgment and anxiety

Design elements that support this:
- Calm, focused UI with clear hierarchy
- Satisfying interactions (swipe to categorize, progress indicators)
- Summary that tells a story, not just shows numbers
- Celebration of completion, not guilt about overspending

### Visual Language

**Award-winning ambition.** The goal is Things 3-level craft. Custom iconography, signature interactions, considered typography, and depth through layering. Female-forward but universally appealing—more wellness app than finance tool.

**Primary palette: Sage & Cream**
```
Canvas:     #FAF8F5 (warm cream)
Surface:    #FFFFFF (white cards)
Sidebar:    #F5F2EE (subtle warmth)

Primary:    #7A9A7E (sage)
Primary Dark: #5C7D60 (sage dark)
Primary Light: #DCE8DE (sage tint)

Accent:     #C49E7A (warm terracotta)
Accent Light: #FDF6EE (warm tint)

Text Primary:   #2C3A2E (warm charcoal)
Text Secondary: #5C6B5E
Text Tertiary:  #8A9A8C
Text Muted:     #B8C4BA
```

Why sage over blue: More distinctive, more aligned with "enough" philosophy (growth, sufficiency, balance), stronger differentiation from competitors. Warmth pairs naturally with cream canvas. See `Mockups/enough-blue-variant.html` for comparison.

**Typography**
- **Display:** Source Serif 4 (Light 300) for large numbers and headings—adds warmth and sophistication
- **UI:** SF Pro Text for body, labels, and interface elements
- **Mono:** SF Mono for amounts and raw transaction data
- The contrast between serif display and sans-serif UI creates visual interest while maintaining readability

**Iconography**
- Custom SVG icons with 1.5px stroke weight
- Each category has a color-coded icon container
- Simple, geometric, hand-crafted feeling
- No emoji anywhere—too casual for the craft level

**Signature Element: Progress Ring**
- Circular progress indicator instead of bar
- Shows percentage used with subtle gradient fill
- Creates visual anchor and memorable identity
- Inspired by Activity Rings but softer, warmer

**Depth & Layering**
- Multiple shadow levels create hierarchy:
  - `shadow-card`: 0 2px 8px rgba(0,0,0,0.04)
  - `shadow-md`: 0 4px 12px rgba(0,0,0,0.06)
  - `shadow-lg`: 0 8px 24px rgba(0,0,0,0.08)
  - `shadow-elevated`: 0 12px 32px rgba(0,0,0,0.1)
- Cards float on canvas, lift on hover
- Everything feels considered and intentional

**Light mode first.** Dark mode can come later. The warm cream backgrounds and sage accents work best in light—like Day One, Things, Bear.

**Reference mockups:**
- `Mockups/enough-refined.html` — Primary design direction (approved)
- `Mockups/enough-blue-variant.html` — Blue alternative for comparison
- `Mockups/enough-mac-exploration.html` — Earlier exploration with palettes

### What Could Evolve

Design elements to explore during build:

**Animation & Motion**
- Progress ring animating when completing weekly review
- Cards with subtle entrance transitions
- Smooth state changes on categorization
- Satisfying feedback on successful actions

**Empty States**
- What does "no transactions" look like?
- First-run experience / onboarding flow
- Zero uncategorized state (celebration moment?)

**The Completion Moment**
- When weekly review finishes, what's the celebration?
- Summary screen with trajectory projection
- Could be the most memorable moment in the app

**Dark Mode**
- Could be dramatic with sage/warm palette
- Lower priority—get light mode perfect first

**Keyboard Shortcuts**
- ⌘I for Import
- ⌘1/2/3 for sections
- Arrow keys + Enter for category selection
- Full keyboard navigation in review flow

## Platform Strategy

### Mac App (Primary)

The main dashboard. Where the weekly review happens. Where you see the full picture.

- Import CSV files
- Categorize transactions
- View dashboard and reports
- Manage settings, categories, rules

### iOS App (Companion)

Quick capture and awareness on the go.

- Log cash transactions manually
- Quick glance at current month
- Receive weekly review reminder
- Not a full replacement for Mac

### Sync

iCloud for seamless device sync. Data never leaves Apple's ecosystem.

## Technical Architecture

### Local-First

- SQLite database on device
- iCloud sync via CloudKit
- No server infrastructure
- No user accounts or authentication

### Data Model (Simplified)

```
Accounts
- id, name, bank, type (checking/savings/credit)

Transactions
- id, account_id, date, amount, raw_description
- merchant_id, category_id
- is_manual, is_reviewed

Merchants
- id, raw_pattern, display_name, default_category_id

Categories
- id, name, icon, color, parent_id

Rules
- id, conditions, actions, priority

Settings
- enough_number, review_day, categories_config
```

### Import Pipeline

1. Parse CSV (detect format from header patterns)
2. Normalize transactions (strip noise, extract merchant)
3. Apply rules and merchant memory
4. Run ML classifier for unknowns
5. Queue uncertain transactions for review

### On-Device ML

- Create ML text classifier
- Base model ships with app (~1000 training examples)
- User corrections stored as training data
- Periodic on-device retraining (weekly, on charger)

## Pricing

**$29/year** — yearly subscription with 14-day trial.

Rationale:
- Yearly aligns with measuring "enough" over full cycles
- Lower than Copilot ($95), YNAB ($109), Monarch ($100)
- Subscription funds ongoing development (bank format updates, ML improvements)
- No free tier—this is for people serious about awareness

Alternative considered: one-time purchase at $39. But unlike Eighty (where the philosophy argues against subscription), Enough requires maintenance (bank formats change, ML needs improvement). Subscription creates alignment to keep the tool working well.

## Go-to-Market

Following the studio playbook:

1. **Exceptional product** — use it myself for 3+ months before launch
2. **Website** — enough.app or alternative (clear positioning, waitlist)
3. **Community** — r/AusFinance, r/fiaustralia, Australian FIRE communities
4. **ProductHunt** — one-time visibility spike
5. **App Store Optimization** — "expense tracker Australia", "spending awareness"

Differentiation messaging:
- "See where your money goes. That's it."
- "The expense tracker that doesn't tell you what to do."
- "Know your enough number."

## Open Questions

### Naming

"Enough" is philosophically perfect. Domain options:
- enough.app ($387/year — premium)
- getenough.app
- useenough.app
- enoughapp.co
- enough.money

The App Store is primary distribution; marketing domain is secondary.

### Scope

**In scope for v1:**
- Mac app with full functionality
- CSV import for major Australian banks
- Core categorization (merchant memory + rules)
- Dashboard with enough number tracking
- iCloud sync

**Deferred:**
- iOS companion app
- On-device ML (start with rules only)
- Advanced reporting
- Export functionality

### The Habit Question

The biggest risk: will weekly import actually happen?

Possible reinforcement mechanisms:
- Weekly notification on chosen day
- "Streak" of consecutive weeks reviewed
- Quick stats in notification ("Last week: $X across Y transactions")
- Make the review satisfying enough that you want to do it

Need to design this carefully—gamification could undermine the philosophy.

### International / Australian Focus

Initial focus on Australian banks:
- ING Australia
- Commonwealth Bank
- ANZ
- Westpac
- NAB
- Up Bank
- Macquarie

Easier to get format detection right for a focused set. Expand later.

## Competitive Positioning

|  | Manual-First | Bank-First |
|--|--------------|------------|
| **Philosophy-Driven** | **Enough** | YNAB |
| **Flexible/Simple** | Lunch Money | Simplifi, Monarch |
| **Design-Forward** | **Enough** | Copilot |
| **Local-First** | **Enough**, Actual Budget | (none) |
| **Native Apple** | **Enough** | Copilot |

Enough occupies unique territory: design-forward, local-first, native Apple, manual-first, with philosophical grounding.

## Success Metrics

**For me personally:**
- Actually using it weekly for 6+ months
- Having real awareness of monthly spending
- Knowing my enough number

**For the product:**
- Week 1 retention (do people complete first review?)
- Weekly active rate (are people doing the ritual?)
- Time to 90% auto-categorization (is the ML working?)
- Subscription renewal rate (does it provide ongoing value?)

---

## What's Next

1. Design exploration — mockups of core screens
2. Technical spike — CSV parsing for Australian banks
3. Core data model implementation
4. Basic Mac app with import + categorization
5. Dashboard with enough number
6. Beta testing (personal use)

---

*This is a living document. Update as the thinking evolves.*
