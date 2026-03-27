# Global VIN Decoder – Flutter Frontend Spec (No Backend)

## Overview

Build the complete **UI/UX frontend** of the Global VIN Decoder app in Flutter using GetX and Clean Architecture. **No real API calls or backend required at this stage.** All data is mocked locally. The architecture must be structured so adding a real backend later requires only swapping the data layer — zero changes to UI or domain.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (latest stable) |
| State Management | GetX |
| Architecture | Clean Architecture (Data / Domain / Presentation) |
| Local Storage | Hive (recent searches + user profile) |
| Mock Data | Hardcoded Dart models (no HTTP calls) |
| Navigation | GetX Named Routes |
| Dependency Injection | GetX (Get.put / Get.lazyPut) |
| Fonts | Google Fonts (Inter + Space Mono) |

---

## Folder Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   └── app_typography.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── utils/
│       └── vin_validator.dart
│
├── features/
│   ├── splash/
│   │   └── presentation/
│   │       └── pages/
│   │           └── splash_page.dart
│   │
│   ├── onboarding/
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── onboarding_controller.dart
│   │       └── pages/
│   │           └── onboarding_page.dart
│   │
│   ├── vin_decoder/
│   │   ├── data/
│   │   │   └── mock/
│   │   │       └── mock_vin_data.dart        ← All fake vehicle data lives here
│   │   ├── domain/
│   │   │   └── entities/
│   │   │       └── vin_entity.dart
│   │   └── presentation/
│   │       ├── bindings/
│   │       │   └── vin_binding.dart
│   │       ├── controllers/
│   │       │   └── vin_controller.dart
│   │       └── pages/
│   │           ├── home_page.dart
│   │           └── vin_result_page.dart
│   │
│   ├── recent_searches/
│   │   ├── data/
│   │   │   └── datasources/
│   │   │       └── recent_search_local_datasource.dart   ← Hive
│   │   ├── domain/
│   │   │   └── entities/
│   │   │       └── recent_search_entity.dart
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── recent_search_controller.dart
│   │       └── widgets/
│   │           └── recent_search_list.dart
│   │
│   ├── subscription/
│   │   ├── domain/
│   │   │   └── entities/
│   │   │       └── plan_entity.dart
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── subscription_controller.dart
│   │       └── pages/
│   │           └── subscription_page.dart
│   │
│   └── profile/
│       ├── data/
│       │   └── datasources/
│       │       └── profile_local_datasource.dart         ← Hive
│       ├── domain/
│       │   └── entities/
│       │       └── user_profile_entity.dart
│       └── presentation/
│           ├── controllers/
│           │   └── profile_controller.dart
│           └── pages/
│               ├── profile_page.dart
│               └── edit_profile_page.dart
│
├── routes/
│   └── app_routes.dart
│
└── main.dart
```

---

## Design System

### Color Palette

```dart
// core/constants/app_colors.dart
class AppColors {
  static const Color background    = Color(0xFF0A0D14);
  static const Color surface       = Color(0xFF141921);
  static const Color surfaceLight  = Color(0xFF1E2535);
  static const Color primary       = Color(0xFF00C6FF);
  static const Color primaryDark   = Color(0xFF0072FF);
  static const Color success       = Color(0xFF00E676);
  static const Color warning       = Color(0xFFFFAB00);
  static const Color error         = Color(0xFFFF5252);
  static const Color textPrimary   = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8B95A8);
  static const Color divider       = Color(0xFF2A3347);
  static const Color gold          = Color(0xFFFFD700);
  static const Color silver        = Color(0xFFC0C0C0);
}
```

### Typography

```dart
// core/constants/app_typography.dart
// Primary font: Inter (all general text)
// Monospace font: Space Mono (VIN numbers, spec values)
// Install via google_fonts package

TextStyle vinDisplay = GoogleFonts.spaceMono(
  fontSize: 18, letterSpacing: 3, color: AppColors.primary,
);
TextStyle heading1 = GoogleFonts.inter(
  fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary,
);
TextStyle body = GoogleFonts.inter(
  fontSize: 14, color: AppColors.textSecondary, letterSpacing: 0.3,
);
```

### UI Style Rules

- **Dark glassmorphism cards**: `BackdropFilter` blur + semi-transparent surface
- **Gradient buttons**: Linear gradient `#00C6FF → #0072FF`, rounded `BorderRadius.circular(12)`
- **Glowing input borders**: `BoxShadow` with `primary.withOpacity(0.4)` on focus
- **Shimmer loaders**: Use shimmer package for all loading placeholders
- **Staggered list animations**: `flutter_animate` with `fadeIn + slideY` stagger
- **All corners**: Cards = `16`, Buttons = `12`, Chips = `20`, Bottom sheet = `24`
- **Bottom nav**: Animated sliding pill indicator

---

## Mock Data

### mock_vin_data.dart

Create a `MockVinData` class with a static `Map<String, VinEntity>` of at least **6 fake VINs**. When the user types any unrecognized VIN, return a random entry from the map so the UI always has something to show.

```dart
// Example entries to include:
// '1HGBH41JXMN109186' → 2021 Honda Civic Sedan
// 'JM1BK343X91234567' → 2009 Mazda 3 Hatchback
// 'WBA3A5G59DNP26082' → 2013 BMW 3 Series
// '2T1BURHE0JC043821' → 2018 Toyota Corolla
// '1FA6P8TH7J5101234' → 2018 Ford Mustang
// '5YJSA1CN5DFP12345' → 2013 Tesla Model S

class MockVinData {
  static VinEntity getByVin(String vin) {
    return _data[vin.toUpperCase()] ?? _data.values.toList()[_randomIndex()];
  }
}
```

### VinEntity Fields

```dart
class VinEntity {
  final String vin;
  final String make;
  final String model;
  final String year;
  final String bodyType;       // Sedan, SUV, Hatchback, etc.
  final String fuelType;       // Petrol, Diesel, Electric, Hybrid
  final String driveType;      // FWD, RWD, AWD, 4WD
  final String transmission;   // Automatic, Manual, CVT
  final String engine;         // e.g. "2.0L 4-Cylinder Turbocharged"
  final String engineHp;       // e.g. "158 HP"
  final String cylinders;
  final String doors;
  final String seats;
  final String country;
  final String manufacturer;
  final String plantCity;
  final String color;          // exterior color
  final String vehicleType;    // Passenger Car, Truck, MPV
  final List<String> equipment;   // factory equipment list
  final String safetyRating;      // e.g. "5-Star NHTSA"
  final List<String> safetyFeatures;
  final String marketValueMin;    // e.g. "$18,000"
  final String marketValueMax;    // e.g. "$22,500"
  final String imageUrl;          // use a placeholder asset image
}
```

---

## Screens & UI

### 1. Splash Screen (`/splash`)

- Full screen dark background with animated logo
- App name: **"VIN Global"** or **"VinDecode"** (your choice — keep consistent)
- Logo: car outline icon + gradient text
- After 2 seconds → check if first launch → route to Onboarding or Home
- Use `flutter_animate` for logo scale + fade entrance

---

### 2. Onboarding (`/onboarding`) — First Launch Only

Three pages with `PageView`, dot indicators, skip button:

**Page 1 – "Decode Any Vehicle"**
- Lottie animation: car driving / scanner animation
- Title + subtitle
- "Next" button

**Page 2 – "Complete Vehicle Data"**
- Lottie animation: document / data visualization
- Title + subtitle

**Page 3 – "Choose Your Plan"**
- Lottie animation: shield / star / trophy
- "Get Started" button → saves `onboardingDone = true` to Hive → navigate to Home

Use free Lottie files from lottiefiles.com (car, document, trophy themes).

---

### 3. Home Screen (`/home`)

**Top Section:**
- App bar: logo left, notification bell right (icon only, no functionality yet)
- Greeting text: "Good morning 👋" (time-based) + user name from profile

**VIN Search Card (center, prominent):**
- Glassmorphism card with slight gradient border
- Title: "Enter Vehicle VIN"
- `TextField` with Space Mono font, auto-uppercase, 17-char limit
- Real-time character counter (e.g. `12 / 17`)
- Inline validation feedback:
  - Neutral: gray border (empty)
  - Typing: blue glowing border
  - Valid: green border + checkmark icon
  - Invalid: red border + error message
- Camera scan icon button (right side of input) — show a `SnackBar` "Camera scan coming soon"
- **"Decode VIN"** gradient button — triggers mock decode with 1.5s fake loading

**Recent Searches Section:**
- Section header: "Recent Searches" + "See All" link
- Horizontal scroll row of `RecentSearchCard` widgets
- Each card: Make + Model, Year chip, VIN (truncated), time ago
- Empty state: dashed border card with "No recent searches yet"

**Quick Stats Row (decorative):**
- 3 small stat chips: "17 Characters", "Global Database", "Instant Results"
- Pure decoration, no interactivity needed

---

### 4. VIN Result Screen (`/vin-result`)

Receives `VinEntity` via GetX arguments.

**Header (non-scrollable):**
- Back button
- VIN number in Space Mono font
- Make + Model + Year as large title
- Country flag emoji + country name
- Vehicle type badge chip

**Tab Bar (4 tabs):**

**Tab 1 – Overview**
- Hero vehicle image (use a colored placeholder asset per vehicle type)
- 2-column info grid cards:
  - Body Type, Fuel Type, Drive Type, Transmission
  - Doors, Seats, Color, Vehicle Type
- Each card: icon + label + value, glassmorphism style

**Tab 2 – Specifications**
- Full spec list in grouped sections:
  - *Engine*: Engine, HP, Cylinders, Displacement
  - *Dimensions*: Doors, Seats, Body Class
  - *Drivetrain*: Transmission, Drive Type, Fuel Type
  - *Identity*: Make, Model, Year, Manufacturer, Plant City
- Each row: label (secondary color) / value (primary color, Space Mono)
- Divider lines between rows

**Tab 3 – Equipment**
- List of equipment strings from `VinEntity.equipment`
- Each item: checkmark icon (success green) + text
- At least 10–15 mock equipment items per vehicle

**Tab 4 – Safety** *(locked for Basic plan)*
- If `subscriptionController.plan == basic`:
  - Show blurred/locked overlay with "Upgrade to Standard" CTA
- If unlocked:
  - Safety rating badge (stars + number)
  - List of safety features with shield icons

**Bottom Action Bar (always visible):**
- "Save" icon button (heart) — show Snackbar "Saved!" (no persistence needed yet)
- "Share" icon button — show Snackbar "Share coming soon"

---

### 5. Recent Searches Screen (`/history`)

- Full list (not just horizontal row)
- Each item: Make/Model, Year, VIN, timestamp, arrow icon
- Tap → re-run decode (navigate to result with same mock data)
- Swipe left → delete with confirm dialog
- FAB: "Clear All" — confirm dialog before clearing Hive box
- Empty state: illustration + "Your search history is empty"
- **Plan limit banner** at top if on Basic plan: "5/5 searches used — Upgrade for more"

---

### 6. Subscription Screen (`/subscription`)

**Header:**
- "Choose Your Plan" title
- "Unlock the full power of VIN decoding" subtitle

**Plan Cards (vertical stack or PageView):**

Each plan card contains:
- Plan name + price
- Badge: "FREE" / "POPULAR" / "BEST VALUE"
- Feature list with check/cross icons
- CTA button

```
Basic (Free)
- 3 decodes/day
- 5 recent searches
- Basic vehicle info only
- Ads shown
[Current Plan / Get Started]

Standard ($4.99/mo)   ← "MOST POPULAR" badge, glowing blue border
- 20 decodes/day
- 20 recent searches
- Full specifications
- Safety ratings
- Ad-free
[Start 7-Day Free Trial]

Premium ($9.99/mo)    ← gold gradient border
- Unlimited decodes
- Unlimited history
- All features
- Market value data
- PDF export
- Priority support
[Start 7-Day Free Trial]
```

**Plan Toggle:**
- Monthly / Yearly toggle at top (yearly shows "Save 30%" badge)
- Yearly pricing: Standard = $2.99/mo billed annually, Premium = $6.99/mo

**Currently Active Plan:**
- Highlighted with a glow border
- "Current Plan" badge instead of CTA

**Bottom note:** "Cancel anytime. No hidden fees."

**Mock purchase flow:**
- Tapping "Start Free Trial" → show a `BottomSheet` with plan summary → "Confirm" → update `SubscriptionController.currentPlan` via GetX → show success snackbar → pop

---

### 7. Profile Screen (`/profile`)

**Profile Header:**
- Large circular avatar (initials-based, colored background)
- Display name + email
- Plan badge chip (gray=Basic, silver=Standard, gold=Premium)
- "Edit Profile" button

**Settings List:**

*Account*
- Edit Profile → `/edit-profile`
- Change Password → show Snackbar "Feature coming soon"
- Notifications → toggle switch (Hive-persisted)

*Preferences*
- Unit System → Bottom sheet picker (Metric / Imperial)
- Language → Bottom sheet picker (English / Arabic / French)

*Subscription*
- Current Plan → show plan name + "Manage" → navigate to `/subscription`
- Billing History → Snackbar "Coming soon"

*About*
- App Version → show `1.0.0`
- Privacy Policy → Snackbar "Opening..." (no WebView yet)
- Terms of Service → same
- Rate the App → Snackbar "Opening store..."
- Contact Support → Snackbar "support@vindecode.com"

*Danger Zone*
- Sign Out → confirm dialog → clear Hive → go to Splash
- Delete Account → confirm dialog → Snackbar "Coming soon"

---

### 8. Edit Profile Screen (`/edit-profile`)

- Avatar with "Change Photo" tap (show `ImagePicker` — just pick, no upload)
- Text fields: Full Name, Email (editable), Phone Number
- Country selector (use `country_picker` package)
- "Save Changes" button → save to Hive via `ProfileController` → show success snackbar → pop

---

## Bottom Navigation Bar

4 tabs with animated sliding pill indicator:

```
[🔍 Decode]   [🕐 History]   [⭐ Favorites*]   [👤 Profile]
```

*Favorites tab: tapping shows a bottom sheet "Upgrade to Standard to save favorites" if on Basic plan.

Active tab: pill background with primary color, icon + label highlighted.
Inactive: icon only, secondary color.

---

## GetX Controllers

### VinController
```dart
// Observables
final RxBool isLoading = false.obs;
final RxString errorMessage = ''.obs;
final Rx<VinEntity?> currentResult = Rx(null);
final RxString inputVin = ''.obs;

// Methods
void decodeVin(String vin) async {
  // 1. Validate format
  // 2. Check plan decode limit (mock: increment counter in Hive)
  // 3. Set isLoading = true
  // 4. await Future.delayed(Duration(milliseconds: 1500)) — fake loading
  // 5. currentResult.value = MockVinData.getByVin(vin)
  // 6. Save to RecentSearchController
  // 7. Navigate to /vin-result
}
```

### RecentSearchController
```dart
// Hive-backed list
final RxList<RecentSearchEntity> searches = <RecentSearchEntity>[].obs;

void addSearch(VinEntity result) { ... }
void removeSearch(String vin) { ... }
void clearAll() { ... }
```

### SubscriptionController
```dart
final Rx<PlanType> currentPlan = PlanType.basic.obs;
// PlanType enum: basic, standard, premium

int get dailyDecodeLimit => currentPlan.value == PlanType.basic ? 3
    : currentPlan.value == PlanType.standard ? 20 : 999;

bool canAccessFeature(String feature) {
  // feature: 'safety', 'market_value', 'favorites', 'pdf'
}

void upgradePlan(PlanType plan) {
  currentPlan.value = plan;
  // Save to Hive
}
```

### ProfileController
```dart
final Rx<UserProfileEntity> profile = UserProfileEntity.empty().obs;

void loadProfile() { ... }    // read from Hive
void saveProfile(UserProfileEntity p) { ... }  // write to Hive
```

---

## Routes

```dart
// routes/app_routes.dart
class AppRoutes {
  static const splash        = '/splash';
  static const onboarding    = '/onboarding';
  static const home          = '/home';
  static const vinResult     = '/vin-result';
  static const history       = '/history';
  static const subscription  = '/subscription';
  static const profile       = '/profile';
  static const editProfile   = '/edit-profile';
}
```

---

## VIN Validator

```dart
// core/utils/vin_validator.dart
class VinValidator {
  static const _vinRegex = r'^[A-HJ-NPR-Z0-9]{17}$';

  static bool isValid(String vin) {
    if (vin.length != 17) return false;
    return RegExp(_vinRegex).hasMatch(vin.toUpperCase());
  }

  static String? errorMessage(String vin) {
    if (vin.isEmpty) return null;
    if (vin.length < 17) return 'VIN must be 17 characters (${vin.length}/17)';
    if (!RegExp(_vinRegex).hasMatch(vin.toUpperCase())) return 'Invalid VIN format';
    return null;
  }
}
```

---

## Hive Storage Schema

| Box Name | Key | Value Type | Notes |
|---|---|---|---|
| `recentSearches` | auto-increment | `RecentSearchEntity` | max 5 (Basic), 20 (Standard), unlimited (Premium) |
| `userProfile` | `'profile'` | `UserProfileEntity` | single object |
| `appSettings` | `'plan'` | String | `'basic' / 'standard' / 'premium'` |
| `appSettings` | `'onboardingDone'` | bool | first launch flag |
| `appSettings` | `'unitSystem'` | String | `'metric' / 'imperial'` |
| `appSettings` | `'language'` | String | `'en' / 'ar' / 'fr'` |
| `appSettings` | `'decodeCount'` | int | resets daily, track date |

---

## Packages (pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  google_fonts: ^6.1.0
  shimmer: ^3.0.0
  lottie: ^3.1.0
  flutter_animate: ^4.5.0
  cached_network_image: ^3.3.1
  image_picker: ^1.0.7
  country_picker: ^2.0.20
  share_plus: ^7.2.2
  intl: ^0.19.0

dev_dependencies:
  hive_generator: ^2.0.1
  build_runner: ^2.4.8
  flutter_lints: ^3.0.0
```

---

## Empty & Error States

Every list/data screen must have all three states:

| State | UI |
|---|---|
| Loading | Shimmer skeleton cards |
| Empty | Centered illustration (use simple SVG or icon) + message + optional CTA |
| Error | Error icon + message + "Try Again" button |

---

## Backend-Ready Architecture Note

> **For the developer:** All mock data is isolated in `lib/features/vin_decoder/data/mock/mock_vin_data.dart`. When adding a real backend:
> 1. Create `vin_remote_datasource.dart` with Dio HTTP calls
> 2. Create `vin_repository_impl.dart` implementing the domain repository
> 3. Replace `MockVinData.getByVin()` call in `VinController` with the use case
> 4. **Zero changes** needed in `domain/` or `presentation/` layers

---

## Build & Run

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

---

## Implementation Order

1. Theme + colors + typography setup
2. Splash + Onboarding screens
3. Bottom navigation shell
4. Home screen + VIN input with validation
5. Mock data models + VinController
6. VIN Result screen (all 4 tabs)
7. Recent Searches (Hive)
8. Subscription screen (UI + mock purchase flow)
9. Profile + Edit Profile (Hive)
10. Polish: animations, empty states, transitions
