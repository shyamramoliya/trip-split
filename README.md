# TripSplit — Smart Travel Itinerary Planner & Expense Splitter

## Overview
TripSplit is a modern, offline-first Flutter application designed to simplify group travel. It helps users manage their trip itineraries and automatically splits expenses among participants using an optimized debt simplification algorithm. The application features a beautiful Material 3 interface, dynamic charts for expense visualization, and robust local-first architecture ensuring it works perfectly even in remote locations without internet access.

## Architecture
TripSplit follows Clean Architecture principles to separate concerns into Domain, Data, and Presentation layers, ensuring maintainability and scalability.

```text
┌──────────────────────────────────────────────────────┐
│                   UI Layer (Riverpod)                │
│   Reads ALWAYS from Hive (local) — fast & offline    │
└─────────────────────┬────────────────────────────────┘
                      │
┌─────────────────────▼────────────────────────────────┐
│              Repository Layer                        │
│  • All CRUD ops write to Hive FIRST                  │
│  • Marks record as isSynced = false                  │
│  • Adds operation to SyncQueue                       │
│  • Returns success immediately to UI                 │
└─────────────────────┬────────────────────────────────┘
                      │
┌─────────────────────▼────────────────────────────────┐
│              SyncService (Background)                │
│  • Monitors connectivity via ConnectivityPlus        │
│  • On network restore: processes SyncQueue           │
│  • Retries failed operations (max 3 attempts)        │
│  • Marks records isSynced = true on success          │
└──────────────────────────────────────────────────────┘
```

The application is structured into domain-specific modules:
- `trips/`: Trip creation, participant management
- `itinerary/`: Daily activity timeline planning
- `expenses/`: Cost tracking, category charts, and debt splitting
- `search/`: Finding specific trips or expenses
- `settings/`: App preferences and sync management

## Tech Stack
| Package | Purpose |
|---------|---------|
| `flutter_riverpod` | Reactive state management and dependency injection |
| `hive_flutter` | High-performance offline-first NoSQL local storage |
| `go_router` | Declarative routing with custom transitions |
| `flutter_animate` | Micro-interactions and fluid screen transitions |
| `fl_chart` | Interactive pie charts and bar charts for expenses |
| `connectivity_plus` | Monitoring network state for the sync queue |
| `dartz` | Functional programming error handling (Either/Failure) |

## Installation

### Prerequisites
- Flutter SDK >= 3.32.0
- Dart >= 3.8.0
- Android Studio / VS Code with Flutter plugin

### Setup Steps
1. Clone the repository
2. Run `flutter pub get`
3. Run `flutter pub run build_runner build --delete-conflicting-outputs`
4. (Optional) Add `google-services.json` to `android/app/` for Firebase sync (initially mocked in `main.dart`)
5. Run `flutter run`

## Commit Sequence
1. `init: project structure and dependencies`
2. `feat: data models and Hive adapters`
3. `feat: trip management module`
4. `feat: itinerary planning module`
5. `feat: expense tracking and splitting algorithm`
6. `feat: dashboard and charts`
7. `feat: offline-first sync architecture`
8. `feat: search and filter`
9. `ui: animations and polishing`
10. `docs: readme and code comments`
