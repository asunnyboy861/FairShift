# FairShift - iOS App Development Guide

## Executive Summary

**FairShift: Mental Load & Chore Balance** is an iOS app that makes the invisible labor of household management visible, trackable, and fairly distributed between partners. Unlike existing chore apps (Cozi, Sweepy, Tody) that only track physical task execution, FairShift introduces the revolutionary **three-layer ownership model** (Conception + Initiation + Execution) based on Eve Rodsky's Fair Play methodology.

**Core Differentiators**:
- **Invisible Task Tracking**: First app to track mental labor (remembering, planning, anticipating) alongside physical chores
- **Fair Play Card Deck**: Digital implementation of Eve Rodsky's 100+ household responsibility cards with swipe-to-assign
- **Three-Layer Ownership**: Conception (who thinks of it) + Initiation (who starts it) + Execution (who does it)
- **Partnership Score**: Measures fairness, not competition — replaces gamification with collaboration
- **Smart Nudge**: Non-judgmental reminders that respect Full Ownership principle
- **Retrospective Proof**: Photo + auto-archive completion logging with zero management overhead

**Target Market**: US (English), couples and cohabiting partners struggling with mental load imbalance
**Tech Stack**: Swift + SwiftUI + SwiftData + CloudKit (sharing) + Swift Charts + UserNotifications
**Minimum iOS**: 17.0
**Bundle ID**: com.zzoutuo.FairShift

---

## Competitive Analysis

| Dimension | Cozi (Free+$29.99/yr) | Sweepy ($2.49/mo) | Tody ($17.99/yr) | Cupla (Free+$4.99/mo) | **FairShift** |
|-----------|---------|----------|--------|---------|-------------|
| Invisible Labor Tracking | No | No | No | No | **Core Feature** |
| Mental Load Visualization | No | No | No | Basic | **Mental Load Map heatmap** |
| Fair Play Method | No | No | No | No | **Built-in Card Deck** |
| 3-Layer Task Ownership | Execution only | Execution only | Execution only | Execution only | **Conception+Initiation+Execution** |
| Fairness Score | No | No | No | Simple comparison | **Partnership Score** |
| Retrospective Proof | No | No | No | Check-in only | **Photo+Auto-archive** |
| Partner Real-time Sync | Family calendar | Single user | Paid version | Real-time | **CloudKit real-time** |
| Monthly Fair Report | No | Cleaning report | Cleaning report | No | **Fair Report PDF** |
| ADHD-friendly Reminders | Generic | Generic | Generic | Generic | **Smart Nudge non-judgmental** |
| Data Privacy | Cloud+Ads | Cloud | Cloud | Cloud | **End-to-end encrypted CloudKit** |
| Gamification | No | Points/streaks | Mascot | Points | **None (collaboration-focused)** |

**Key Insight**: No existing app tracks the mental/invisible labor that is the root cause of household imbalance. FairShift is the first to address this gap.

---

## Technical Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    FairShift Architecture                     │
├─────────────────────────────────────────────────────────────┤
│  View Layer (SwiftUI)                                        │
│  ├── TodayView / CardsView / BalanceView / LogView / Settings│
│  ├── MVVM pattern with @Observable ViewModels                │
│  └── SwiftData @Query for reactive data binding              │
├─────────────────────────────────────────────────────────────┤
│  Logic Layer (ViewModels)                                    │
│  ├── TodayViewModel / CardsViewModel / BalanceViewModel      │
│  ├── LogViewModel / SettingsViewModel                        │
│  └── OnboardingViewModel                                     │
├─────────────────────────────────────────────────────────────┤
│  Data Layer (SwiftData)                                      │
│  ├── ChoreTask / Partner / TaskCompletion / FairPlayCard     │
│  ├── EffortScoreCalculator / SmartNudgeEngine                │
│  └── Local-first with CloudKit sync option                   │
├─────────────────────────────────────────────────────────────┤
│  Sync Layer (CloudKit)                                       │
│  ├── CKShare for partner sharing                             │
│  ├── Offline-first with auto-sync                            │
│  └── End-to-end encrypted                                    │
├─────────────────────────────────────────────────────────────┤
│  System Services                                             │
│  ├── UserNotifications (Smart Nudge)                         │
│  ├── PhotosUI (Retrospective Proof)                          │
│  ├── Swift Charts (Mental Load Map, Balance charts)          │
│  ├── WidgetKit (Home screen widget)                          │
│  └── StoreKit 2 (Subscription management)                    │
└─────────────────────────────────────────────────────────────┘
```

---

## Module Structure & File Organization

```
FairShift/
├── App/
│   ├── FairShiftApp.swift
│   └── ContentView.swift
├── Models/
│   ├── ChoreTask.swift
│   ├── Partner.swift
│   ├── TaskCompletion.swift
│   ├── FairPlayCard.swift
│   ├── ChoreCategory.swift
│   ├── OwnershipType.swift
│   ├── EffortWeight.swift
│   ├── TaskFrequency.swift
│   └── BalanceStatus.swift
├── ViewModels/
│   ├── TodayViewModel.swift
│   ├── CardsViewModel.swift
│   ├── BalanceViewModel.swift
│   ├── LogViewModel.swift
│   ├── SettingsViewModel.swift
│   └── OnboardingViewModel.swift
├── Views/
│   ├── Today/
│   │   ├── TodayView.swift
│   │   ├── PartnershipScoreCard.swift
│   │   └── TaskListView.swift
│   ├── Cards/
│   │   ├── CardsView.swift
│   │   ├── CardSwipeView.swift
│   │   └── CardDetailView.swift
│   ├── Balance/
│   │   ├── BalanceView.swift
│   │   ├── OwnershipBreakdownView.swift
│   │   ├── MentalLoadMapView.swift
│   │   └── InsightCardView.swift
│   ├── Log/
│   │   ├── LogView.swift
│   │   ├── QuickLogView.swift
│   │   └── CompletionRowView.swift
│   ├── Settings/
│   │   ├── SettingsView.swift
│   │   ├── PartnerManagementView.swift
│   │   ├── NotificationPreferencesView.swift
│   │   └── PaywallView.swift
│   ├── Onboarding/
│   │   ├── OnboardingView.swift
│   │   ├── CreateProfileStep.swift
│   │   ├── InvitePartnerStep.swift
│   │   └── CardDeckSetupStep.swift
│   └── Shared/
│       ├── ChoreTaskRow.swift
│       ├── PartnerBadge.swift
│       └── EffortBarView.swift
├── Engines/
│   ├── EffortScoreCalculator.swift
│   ├── FairPlayCardDeck.swift
│   ├── SmartNudgeEngine.swift
│   └── PatternRadarAnalyzer.swift
├── Services/
│   ├── CloudKitSyncManager.swift
│   ├── NotificationManager.swift
│   └── PurchaseManager.swift
├── Extensions/
│   ├── Color+FairShift.swift
│   ├── Date+Helpers.swift
│   └── View+Helpers.swift
└── Resources/
    └── Assets.xcassets/
```

---

## Implementation Flow

### Phase 1: Foundation (Models + Data Layer)
1. Create all SwiftData models (ChoreTask, Partner, TaskCompletion, FairPlayCard)
2. Define all enums (ChoreCategory, OwnershipType, EffortWeight, TaskFrequency, BalanceStatus)
3. Set up ModelContainer with all model types
4. Create EffortScoreCalculator engine
5. Create FairPlayCardDeck with 100+ preset cards

### Phase 2: Core UI (TabView + Today + Log)
1. Build TabView navigation with 5 tabs (Today, Cards, Balance, Log, Settings)
2. Implement TodayView with Partnership Score card and task list
3. Implement LogView with Quick Log (photo + time + notes)
4. Create ChoreTaskRow shared component
5. Create PartnerBadge shared component

### Phase 3: Fair Play Cards + Partner System
1. Implement CardsView with card deck browser
2. Implement CardSwipeView (Tinder-style swipe to assign)
3. Implement Partner model and creation flow
4. Create OnboardingView (3 steps: profile, invite, card setup)

### Phase 4: Balance Dashboard + Visualization
1. Implement BalanceView with Partnership Score ring
2. Implement OwnershipBreakdownView (3-layer bar charts)
3. Implement MentalLoadMapView (heatmap with Swift Charts)
4. Implement InsightCardView (AI-generated suggestions)

### Phase 5: Smart Nudge + Notifications
1. Implement SmartNudgeEngine with non-judgmental templates
2. Set up UserNotifications with custom categories
3. Implement notification scheduling based on task due dates

### Phase 6: Settings + IAP + Policy
1. Implement SettingsView with all sections
2. Implement PurchaseManager with StoreKit 2
3. Implement PaywallView following Apple IAP rules
4. Add Contact Support page
5. Add policy page links

### Phase 7: Polish + Testing
1. Add animations and micro-interactions
2. Test on iPhone and iPad simulators
3. Verify dark mode support
4. Verify accessibility (VoiceOver, Dynamic Type)

---

## UI/UX Design Specifications

### Design Philosophy: Warm, Inclusive, Non-confrontational

**Design Keywords**: Warm / Collaborative / Insightful / Safe / Modern

**AVOID**:
- Red warnings (= blame/confrontation)
- Leaderboards (= competition, not collaboration)
- Skull/X marks (= punishment)
- Dark + sharp design (= corporate/productivity feel)

### Color Palette

| Role | Color | Hex (Light) | Hex (Dark) |
|------|-------|-------------|------------|
| Background | Warm Cream | #FFF8F0 | #1A1A2E |
| Primary Accent | Sage Green | #7CB384 | #5A9B64 |
| Secondary Background | Sand Beige | #E8DCC8 | #2A2A3E |
| Partner A | Coral | #F4845F | #D4694F |
| Partner B | Teal | #4ECDC4 | #3BA89F |
| Needs Attention | Amber | #FFB347 | #E09530 |
| Balanced | Soft Green | #7CB384 | #5A9B64 |
| Invisible Labor | Rose | #E8A0BF | #C87FA0 |

### Typography

| Style | Font | Size | Weight |
|-------|------|------|--------|
| Large Title | SF Pro Rounded | 28pt | Bold |
| Card Title | SF Pro Rounded | 20pt | Semibold |
| List Item | SF Pro Rounded | 16pt | Semibold |
| Body | SF Pro Text | 14pt | Regular |
| Caption | SF Pro Text | 12pt | Regular |
| Data/Mono | SF Pro Mono | 14pt | Medium |

### Component Specs

- **Card corner radius**: 16pt (task cards), 24pt (Fair Play cards)
- **Button corner radius**: 12pt
- **Shadow**: Soft, subtle
- **Partner color left border** on task cards
- **Brain icon pulse** for invisible labor items

### 5-Tab Navigation

| Tab | Icon | Title | Description |
|-----|------|-------|-------------|
| 1 | house.fill | Today | Daily tasks, Partnership Score, Quick Log |
| 2 | deck | Cards | Fair Play Card Deck browser and swipe |
| 3 | scale.3d | Balance | Fairness dashboard, Mental Load Map |
| 4 | checkmark.circle | Log | Completion history, Quick Log entry |
| 5 | gearshape.fill | Settings | Partner, notifications, subscription |

---

## Code Generation Rules

1. Use `@Observable` macro (iOS 17+), NOT `ObservableObject`
2. Use SwiftData `@Query` for data fetching, `@Environment(\.modelContext)` for mutations
3. All colors via Asset Catalog with light/dark variants
4. Use `#Preview` macro for previews
5. All SwiftData model attributes MUST be optional OR have default values
6. All SwiftData relationships MUST have inverse relationships
7. NEVER hardcode version numbers — read from `Bundle.main.infoDictionary`
8. iPad: Add `.frame(maxWidth: 720).frame(maxWidth: .infinity)` to main ScrollView content
9. NEVER use `.tabViewStyle(.sidebarAdaptable)` or similar restrictive styles
10. Use `Color.accentColor` instead of `ShapeStyle.accent`
11. Do NOT use iOS 18+ only APIs when targeting iOS 17+
12. Do NOT add comments in code unless asked
13. Follow MVVM pattern strictly
14. Use StoreKit 2 for all IAP operations
15. Dynamic pricing from StoreKit — NEVER hardcode prices

---

## Testing & Validation Standards

1. **Build Test**: Must compile with zero errors on both iPhone and iPad simulators
2. **iPhone Testing**: iPhone XS Max (6.5" display)
3. **iPad Testing**: iPad Pro 13-inch M4 (12.9" display)
4. **Dark Mode**: All views must render correctly in dark mode
5. **Accessibility**: VoiceOver labels on all interactive elements, Dynamic Type support
6. **IAP Compliance**: Paywall follows all Apple IAP rules (no dark patterns)
7. **Data Integrity**: SwiftData models must handle all edge cases (nil values, empty states)

---

## Build & Deployment Checklist

- [ ] Xcode project configured with correct Bundle ID (com.zzoutuo.FairShift)
- [ ] iOS Deployment Target set to 17.0
- [ ] All SwiftData models compile without errors
- [ ] All 5 tab views render correctly on iPhone and iPad
- [ ] CloudKit capability configured (if needed)
- [ ] Notifications capability configured
- [ ] StoreKit configuration file created for IAP testing
- [ ] App icon generated and added to Assets
- [ ] Policy pages deployed to GitHub Pages
- [ ] App Store metadata prepared (keytext.md)
- [ ] Screenshots captured for iPhone and iPad
- [ ] Build succeeds on both simulators
