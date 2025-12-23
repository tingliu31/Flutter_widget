# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter widget learning project that demonstrates various Flutter UI patterns and state management approaches. The project includes examples of layout widgets (Container, Row, Column), custom reusable widgets, and Provider-based state management.

## Development Commands

### Setup and Dependencies
```bash
# Install dependencies
flutter pub get

# Update dependencies
flutter pub upgrade
```

### Running the App
```bash
# Run on connected device/emulator
flutter run

# Run on specific device
flutter devices  # List available devices
flutter run -d <device-id>

# Run with hot reload enabled (default)
flutter run
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run tests with coverage
flutter test --coverage
```

### Code Quality
```bash
# Analyze code (uses analysis_options.yaml)
flutter analyze

# Format code
flutter format lib/

# Format specific file
flutter format lib/main.dart
```

### Building
```bash
# Build APK (Android)
flutter build apk

# Build app bundle (Android)
flutter build appbundle

# Build iOS (requires macOS)
flutter build ios

# Build for web
flutter build web
```

## Architecture

### State Management Pattern
The app uses **Provider** (ChangeNotifier pattern) for state management:

1. **Models** (`lib/models/`) - Define data models that extend `ChangeNotifier`
   - Call `notifyListeners()` when state changes
   - Example: `CounterModel` manages counter state

2. **Provider Setup** (in `main.dart`) - Wrap `MaterialApp` with `ChangeNotifierProvider`
   - Provides state to the entire widget tree

3. **Consuming State** (in pages/widgets):
   - `context.watch<T>()` - Rebuilds when state changes
   - `context.read<T>()` - Access without rebuilding (for callbacks)

### Project Structure
```
lib/
├── main.dart           # App entry point, provider setup
├── models/             # ChangeNotifier state models
├── pages/              # Full-page screens (Scaffold-based)
└── widgets/            # Reusable UI components
```

### Key Patterns

**Page Structure**: Each page is a `StatelessWidget` with a `Scaffold` containing `AppBar` and `body`

**Reusable Widgets**: Custom widgets accept configuration via constructor parameters (e.g., `BorderedImage` accepts `image`, `size`, `borderWidth`, etc.)

**Layout Components**: The project includes example implementations of:
- `Container` with padding/color
- `Row` with various `MainAxisAlignment` options and `Expanded` flex layouts
- `Column` with spacing controls

## Assets
Images are stored in `assets/images/` and must be declared in `pubspec.yaml` under the `assets` section before use with `AssetImage`.

## Code Style Notes
- Chinese comments are used throughout for educational purposes
- Uses `const` constructors where possible for optimization
- Follows standard Flutter/Dart naming conventions (PascalCase for classes, camelCase for variables)
