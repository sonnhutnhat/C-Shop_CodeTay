# C-Shop Mobile Base

Flutter base reconstructed from the conventions of the reference C-Shop
project. This repository currently contains infrastructure only; business
features are intentionally not implemented.

## Base structure

```text
lib/
├── common/          # Theme tokens, assets and shared navigation helpers
├── configs/         # Environment and app-level configuration
├── database/        # Secure storage and shared preferences
├── global/          # Process-wide session/event state
├── global_blocs/    # App-level Cubits
├── models/          # Shared entities, enums and response wrappers
├── network/         # Dio setup, interceptors, endpoints and API errors
├── repositories/    # Base repository behavior
├── router/          # GoRouter configuration
├── services/        # App-level service entrypoints
├── ui/
│   ├── pages/base/  # Temporary base verification page
│   └── widgets/     # Reusable CShop widgets
├── utils/           # Formatting, validation and logging
├── app.dart
├── main.dart
├── main_dev.dart
└── main_prod.dart
```

## Entrypoints

```bash
flutter run -t lib/main_dev.dart
flutter run -t lib/main_prod.dart
```

Base URLs can be overridden without committing secrets:

```bash
flutter run -t lib/main_dev.dart \
  --dart-define=CSHOP_DEV_BASE_URL=https://example.test/cshop
```

The staging and production URLs currently fall back to the reference project's
UAT endpoint. Override them once final endpoints are confirmed.

See [docs/roadmap.md](docs/roadmap.md) for the implementation index.
