# My Skin Routine

> Your skincare companion — track products, routines & skin health.

**My Skin Routine** is a cross-platform mobile app (Android + iOS) built with Flutter that helps users organize and track their skincare routines. 100% offline, privacy-first, no account needed, no tracking, no ads.

## Table of Contents

- [Key Features](#key-features)
- [Tech Stack](#tech-stack)
- [Screenshots](#screenshots)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Database Schema](#database-schema)
- [Internationalization](#internationalization)
- [Building](#building)
- [Testing](#testing)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [License](#license)

## Key Features

- **237 pre-loaded products** from 50+ popular skincare brands with images
- **Custom routines** with flexible recurrence (daily, every N days)
- **Daily dashboard** with action checklists and progress tracking
- **Streak tracking** — consecutive days of completed routines
- **Skin journal** — daily skin condition logging with photos and mood
- **Export/Import** — ZIP backup with all data and images
- **Notifications** — scheduled reminders for each routine
- **Dark mode** + **Dynamic Color** (Android 12+)
- **Multilingual** — French and English
- **100% offline** — no network permission, no cloud, no tracking
- **Guided onboarding** with spotlight tutorials
- **Reorderable routines** — drag to set display order

## Tech Stack

| Component | Technology |
|-----------|-----------|
| **Framework** | Flutter 3.41+ |
| **Language** | Dart 3.11+ |
| **State Management** | Riverpod 3.x (with code generation) |
| **Navigation** | GoRouter |
| **Database** | Drift (SQLite) |
| **Models** | Freezed (immutable data classes) |
| **Design System** | Material Design 3 Expressive |
| **Animations** | flutter_animate + spring physics |
| **Notifications** | flutter_local_notifications |
| **i18n** | Flutter gen-l10n (ARB files) |
| **Fonts** | Outfit + DM Sans (bundled, offline) |

## Screenshots

*Coming soon — see the app in action on Android and iOS.*

## Architecture

### Clean Architecture (3 layers)

```
┌─────────────────────────────────────────────────┐
│              PRESENTATION LAYER                  │
│  Screen (Widget) ← watch() → Riverpod Provider  │
│  Provider manages state via AsyncValue           │
└───────────────────────┬─────────────────────────┘
                        │ calls
┌───────────────────────▼─────────────────────────┐
│                  DOMAIN LAYER                    │
│  Repository (abstract) ← Model (Freezed)        │
└───────────────────────┬─────────────────────────┘
                        │ implements
┌───────────────────────▼─────────────────────────┐
│                   DATA LAYER                     │
│  RepositoryImpl ←→ Drift DAO ←→ SQLite local    │
└─────────────────────────────────────────────────┘
```

### Data Flow (unidirectional)

1. User interacts with a **Screen** (Widget)
2. Screen does `ref.watch(provider)` to read state
3. Screen does `ref.read(provider).method()` to mutate
4. **Repository** executes the operation via **Drift DAO**
5. Drift emits a `Stream` on data change
6. **StreamProvider** auto-updates the UI

## Getting Started

### Prerequisites

- **Flutter** 3.27+ ([install guide](https://docs.flutter.dev/get-started/install))
- **Android Studio** or **Xcode** (for emulators/devices)
- **Git**

### 1. Clone the Repository

```bash
git clone https://github.com/your-org/my-skin-routine.git
cd my-skin-routine
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Generate Code

Drift, Freezed, Riverpod, and JSON serializable all require code generation:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Generate Localizations

```bash
flutter gen-l10n
```

### 5. Run the App

```bash
# On a connected device or emulator
flutter run

# Specific device
flutter run -d <device-id>

# List available devices
flutter devices
```

### 6. Run Tests

```bash
flutter test
```

## Project Structure

```
lib/
├── main.dart                     # Entry point
├── app.dart                      # MaterialApp.router with theme/locale
│
├── core/
│   ├── constants/
│   │   ├── app_constants.dart    # App-wide constants
│   │   └── enums.dart            # ProductType, BodyZone, SkinGoal, RecurrenceType
│   ├── extensions/               # DateTime, BuildContext, String extensions
│   ├── utils/
│   │   ├── notification_utils.dart   # Local notifications service
│   │   ├── photo_utils.dart          # Photo save/delete/resize
│   │   ├── recurrence_utils.dart     # Action scheduling logic
│   │   ├── seed_utils.dart           # DB seeding on first launch
│   │   └── streak_calculator.dart    # Streak computation
│   └── errors/
│       └── failures.dart         # Sealed failure classes
│
├── data/
│   ├── database/
│   │   ├── app_database.dart     # Drift database definition
│   │   ├── tables/               # 5 Drift table definitions
│   │   └── daos/                 # Data Access Objects
│   ├── repositories/             # Repository implementations
│   └── seed/
│       └── product_seed_data.dart # 237 pre-loaded products
│
├── domain/
│   ├── models/                   # Freezed immutable models
│   └── repositories/             # Abstract repository interfaces
│
├── presentation/
│   ├── providers/                # Riverpod providers (7 files)
│   ├── router/
│   │   └── app_router.dart       # GoRouter with StatefulShellRoute
│   ├── theme/
│   │   ├── app_theme.dart        # M3 ThemeData (light + dark)
│   │   ├── app_colors.dart       # Brand lavender palette
│   │   ├── app_typography.dart   # Outfit + DM Sans type scale
│   │   └── app_motion.dart       # Spring physics constants
│   ├── widgets/                  # Reusable components
│   └── screens/
│       ├── splash/               # Animated splash screen
│       ├── onboarding/           # 3-step onboarding wizard
│       ├── home/                 # Daily dashboard with action checklists
│       ├── products/             # Product CRUD (list, detail, form)
│       ├── routines/             # Routine CRUD + action management
│       ├── progress/             # Calendar, streaks, journal
│       ├── journal/              # Skin journal entry form
│       └── settings/             # Theme, language, export/import
│
└── l10n/
    ├── app_fr.arb                # French translations (~120 keys)
    └── app_en.arb                # English translations
```

## Database Schema

5 tables managed by Drift (SQLite):

```
products (237 pre-seeded)
├── id, name, brand, type, photoPath?, notes?
├── createdAt, updatedAt

routines
├── id, name, description?, bodyZone, skinGoal
├── reminderTime?, isActive, sortOrder
├── createdAt, updatedAt

actions (belong to routine)
├── id, routineId (FK→routines CASCADE)
├── productId? (FK→products SET NULL)
├── name, description?, sortOrder
├── recurrenceType, recurrenceInterval, recurrenceStartDate
├── createdAt

action_completions (composite PK)
├── actionId (FK→actions CASCADE)
├── completedDate ("2026-03-24")
├── completedAt

skin_journal
├── id, date, photoPath?, notes, skinFeeling (1-5)
├── createdAt
```

## Internationalization

The app supports French (default) and English. Translations use Flutter's official `gen-l10n` system with ARB files.

| File | Purpose |
|------|---------|
| `lib/l10n/app_fr.arb` | French translations (template) |
| `lib/l10n/app_en.arb` | English translations |
| `l10n.yaml` | Generation config |

Access in code: `context.l10n.keyName` (via context extension).

To add a new language, create `lib/l10n/app_XX.arb` and add the locale to `supportedLocales` in `app.dart`.

## Building

### Debug APK

```bash
flutter build apk --debug
# Output: build/app/outputs/flutter-apk/app-debug.apk
```

### Release APK (split by ABI for smaller size)

```bash
flutter build apk --release --split-per-abi
# Output:
#   app-armeabi-v7a-release.apk  (~25 MB)
#   app-arm64-v8a-release.apk    (~27 MB)
#   app-x86_64-release.apk       (~28 MB)
```

### App Bundle (Play Store)

```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

### iOS (requires macOS + Xcode)

```bash
flutter build ios --release
```

## Testing

```bash
# All tests
flutter test

# Specific test file
flutter test test/unit/streak_calculator_test.dart

# With coverage
flutter test --coverage

# Analyze code
flutter analyze
```

### Test Structure

```
test/
├── unit/                  # Domain logic tests
│   ├── recurrence_utils_test.dart
│   ├── streak_calculator_test.dart
│   └── usecases/
├── widget/                # Widget tests
│   ├── product_card_test.dart
│   └── recurrence_picker_test.dart
└── integration/
    └── app_test.dart
```

## Deployment

### Google Play Store

| Field | Value |
|-------|-------|
| Package name | `com.ronylicha.myskinroutine` |
| Category | Health & Wellness > Beauty |
| Content rating | PEGI 3 |
| Data safety | "No data collected", "No data shared" |

Release signing uses the `key.properties` pattern: generate a keystore once
(see [Flutter docs](https://docs.flutter.dev/deployment/android#create-a-keystore)),
then fill `android/key.properties` with `storePassword`, `keyPassword`,
`keyAlias` and `storeFile`. The file is gitignored and the keystore must be
backed up outside the repository — losing it prevents publishing updates.

### Apple App Store

| Field | Value |
|-------|-------|
| Bundle ID | `com.qrcommunication.mySkinRoutine` |
| Category | Health & Fitness > Skincare |
| Age rating | 4+ |
| Privacy | "Data Not Collected" for all categories |

### Privacy Manifest (iOS)

`ios/Runner/PrivacyInfo.xcprivacy` declares:
- `NSPrivacyAccessedAPICategoryUserDefaults` (SharedPreferences)
- `NSPrivacyAccessedAPICategoryFileTimestamp` (file operations)
- `NSPrivacyTracking: false`
- `NSPrivacyCollectedDataTypes: []` (no data collected)

## Troubleshooting

### `failed to load dynamic library libsqlite3.so`

Use `sqlite3_flutter_libs: 0.5.28` (the 0.6.0+eol version is broken).

### Build fails with `core library desugaring`

Add to `android/app/build.gradle.kts`:
```kotlin
compileOptions {
    isCoreLibraryDesugaringEnabled = true
}
dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
```

### Notification init fails with timezone error

The app handles this gracefully with fallbacks (Europe/Paris → device default). Notifications still work.

### Freezed models show `non_abstract_class_inherits_abstract_member`

Freezed 3.x requires `abstract` keyword:
```dart
@freezed
abstract class Product with _$Product { ... }
```

## Contributing

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Run code generation: `dart run build_runner build --delete-conflicting-outputs`
4. Ensure `flutter analyze` shows 0 errors
5. Commit your changes: `git commit -m 'feat: add amazing feature'`
6. Push to the branch: `git push origin feature/amazing-feature`
7. Open a Pull Request

## License

See [LICENSE](LICENSE) for details.

---

**Built with Flutter** | **Designed with Material 3 Expressive** | **Privacy-first**
