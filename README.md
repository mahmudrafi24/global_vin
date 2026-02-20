# Global VIN

A Flutter application for Vehicle Identification Number (VIN) checking, built with **Clean Architecture**, **GetX** state management, and a private **core_kit** component library.

## Tech Stack

| Technology | Purpose |
|---|---|
| Flutter 3.x (Dart 3+) | Cross-platform UI framework |
| GetX | State management, dependency injection, routing |
| core_kit | Private shared library — networking (Dio), UI components, responsive utilities |
| GetStorage | Lightweight persistent key-value storage |
| connectivity_plus | Network connectivity detection |

## Architecture

The project follows **Clean Architecture** with strict layer separation. Dependencies flow inward — the domain layer has zero external dependencies.

```
lib/
├── main.dart                  # App entry point, service initialization
├── app.dart                   # GetMaterialApp + CoreKit configuration
│
├── core/                      # Shared infrastructure
│   ├── constants/             # API endpoints, app config, asset paths
│   ├── errors/                # Exceptions (data layer) & Failures (domain layer)
│   ├── network/               # API client, network connectivity checker
│   ├── theme/                 # Colors, dimensions, text styles, ThemeData
│   └── utils/                 # Helpers, validators, formatters, extensions
│
├── data/                      # Data layer
│   ├── models/                # JSON-serializable models (extend domain entities)
│   ├── providers/             # Local (storage, cache) & remote (API) data sources
│   ├── datasources/           # Datasource abstractions
│   └── repositories/          # Repository implementations
│
├── domain/                    # Domain layer (pure Dart, no framework deps)
│   ├── entities/              # Business objects
│   ├── repositories/          # Repository contracts (abstract classes)
│   └── usecases/              # Single-responsibility business logic
│
├── presentation/              # UI layer
│   ├── bindings/              # GetX dependency injection per page/feature
│   ├── controllers/           # GetX controllers (view models)
│   ├── pages/                 # Screen widgets organized by feature
│   └── widgets/               # Reusable UI components
│
├── routes/                    # Route constants and page definitions
├── services/                  # App-level singleton services
└── translations/              # i18n (English + Bengali)
```

## Data Flow

```
UI (Page) → Controller → UseCase → Repository (contract) → Repository (impl) → Provider → API / Storage
```

- **Exceptions** are thrown in the data layer and caught by repository implementations
- **Failures** are returned from repositories to controllers using Dart 3 records: `({UserEntity? user, Failure? failure})`
- No third-party `Either` / `dartz` — uses native Dart records for result types

## Key Patterns

| Pattern | Usage |
|---|---|
| Repository Pattern | Abstract contracts in `domain/`, implementations in `data/` |
| Use Case Pattern | `LoginUseCase`, `RegisterUseCase` — callable objects with a single `call()` method |
| Dependency Inversion | Controllers depend on abstract repositories, never concrete implementations |
| GetX Bindings | Page-scoped DI — dependencies are lazily registered when a route is entered |
| Fenix Singletons | Core services use `Get.lazyPut(fenix: true)` so they persist across route changes |
| Exception → Failure | Data layer throws `ServerException`, repos convert to `ServerFailure` for the domain |
| Responsive Design | `designSize: Size(375, 812)` — all sizes use `.w`, `.h`, `.sp` extensions from core_kit |

## Screens

| Screen | Route | Description |
|---|---|---|
| Splash | `/` | Loading screen with app logo, auto-navigates to login |
| Login | `/login` | Email + password form with validation |
| Register | `/register` | Registration form (name, email, password, confirm password) |
| Home | `/home` | Main screen (placeholder for VIN check features) |

## Project Setup

### Prerequisites

- Flutter SDK `>=3.0.0 <4.0.0`
- Dart SDK 3+
- Access to the [core_kit](https://github.com/mahmudrafi24/core_kit) private repository

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd global_vin

# Install dependencies
flutter pub get

# Generate asset references (optional)
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Change Package Name

```bash
flutter pub run change_app_package_name:main com.your.package.name
```

## Configuration

### API Endpoints

All API configuration is in `lib/core/constants/api_constants.dart`:

```dart
abstract class ApiConstants {
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = '/api/v1';

  static const String login = '$apiVersion/auth/login';
  static const String register = '$apiVersion/auth/register';
  static const String refreshToken = '$apiVersion/auth/refresh-token';
  // ...
}
```

Update `baseUrl` to point to your backend before running.

### Token Management

Tokens are stored in `GetStorage` under keys `access_token` and `refresh_token`. The `core_kit` Dio interceptor automatically:
- Injects the access token into request headers
- Handles 401 responses by calling the refresh token endpoint
- Invokes the logout callback when refresh fails

### Theme

The theme system is in `lib/core/theme/`:
- `app_colors.dart` — Color palette (primary blue `#1E88E5`, secondary teal `#26A69A`)
- `app_dimensions.dart` — Standardized spacing, radii, and sizes
- `app_text_styles.dart` — Typography presets
- `app_theme.dart` — Material 3 `ThemeData` (light + dark)

### Translations

English (`en_US`) and Bengali (`bn_BD`) translations are defined in `lib/translations/`. To enable them, wire `AppTranslations` into `GetMaterialApp`.

## core_kit

The `core_kit` package (private, git-sourced) provides shared infrastructure:

**Networking:** `DioService`, `RequestInput`, `ResponseState`, automatic token refresh, debug logging

**UI Components:** `CommonButton`, `CommonTextField`, `CommonText`, `CommonLoader`, `CommonAppBar`, `CommonDialogWithActions`

**Validation:** `ValidationType` enum with 23+ built-in validators (email, password, phone, etc.)

**Utilities:** `CoreUtils` (formatters), `showSnackBar`, responsive extensions (`.w`, `.h`, `.sp`, `.r`)

**Transitive dependencies:** Dio, cached_network_image, flutter_svg, image_picker, file_picker, permission_handler, share_plus, skeletonizer, intl, and more.

## Adding a New Feature

1. **Entity** — Define the business object in `domain/entities/`
2. **Repository contract** — Add abstract methods in `domain/repositories/`
3. **Use case** — Create a callable class in `domain/usecases/`
4. **Model** — Extend the entity with JSON serialization in `data/models/`
5. **Provider** — Add API calls in `data/providers/remote/`
6. **Repository impl** — Implement the contract in `data/repositories/`
7. **Controller** — Create a GetX controller in `presentation/controllers/`
8. **Binding** — Wire dependencies in `presentation/bindings/`
9. **Page** — Build the UI in `presentation/pages/`
10. **Route** — Register in `routes/app_routes.dart` and `routes/app_pages.dart`

## Dependencies

### Production

| Package | Version |
|---|---|
| get | ^4.7.3 |
| get_storage | ^2.1.1 |
| connectivity_plus | ^6.1.0 |
| core_kit | git v1.0.0 |
| cupertino_icons | ^1.0.8 |

### Development

| Package | Purpose |
|---|---|
| flutter_lints | Lint rules |
| build_runner | Code generation |
| flutter_gen_runner | Asset code generation |
| change_app_package_name | Package ID renaming |
