# MDD Blog Mobile Application

**An intern project by BITELLE Co., Ltd.**

> A modern, high-performance Flutter blog application with responsive UI, advanced caching, and seamless authentication.

---

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Key Features](#key-features)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Environment Setup](#environment-setup)
- [Installation & Setup Guide](#installation--setup-guide)
- [Running the Application](#running-the-application)
- [Project Structure](#project-structure)
- [Performance Optimizations](#performance-optimizations)
- [Development Workflow](#development-workflow)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

---

## 🎯 Project Overview

**MDD Blog** is a feature-rich Flutter mobile application that delivers blog content with a focus on **performance**, **user experience**, and **accessibility**. Built for iOS and Android platforms, the app showcases modern Flutter best practices including:

- Efficient state management using GetX
- Image caching and skeleton placeholders to reduce jank
- Responsive design for all screen sizes
- Seamless OAuth and biometric authentication
- Rich markdown and HTML content rendering

This is an **intern training project** at **BITELLE Co., Ltd.**, designed to demonstrate enterprise-grade mobile development practices.

---

## ✨ Key Features

### Content & Discovery

- 📖 Blog list with pagination and search functionality
- 🏷️ Category-based blog browsing
- 📌 Related posts and recommendations
- ❓ FAQ section with performance optimization

### User Experience

- 🔐 OAuth (Google Sign-In) and email authentication
- 👆 Biometric login support (fingerprint/face recognition)
- 📝 Comment system on blog posts
- 🌓 Dark/Light theme support
- 🎨 Responsive UI for mobile, tablet, and web

### Performance

- ⚡ Image caching with `cached_network_image`
- 🖼️ Skeleton loading placeholders
- 📊 SliverList for efficient scrolling
- 🎯 Optimized GetX state management with minimal rebuild scope

### Technical Excellence

- 🛡️ Secure token storage using `flutter_secure_storage`
- 🔗 Deep linking support via `app_links`
- 📱 Multi-platform support (iOS, Android, Web, macOS, Windows, Linux)
- ♿ Accessibility-first UI components

---

## 🛠️ Tech Stack

| Layer                 | Technologies                       |
| --------------------- | ---------------------------------- |
| **Framework**         | Flutter 3.7.2+                     |
| **State Management**  | GetX 4.7.2                         |
| **HTTP Client**       | Dio 5.9.0                          |
| **UI Components**     | Material Design 3                  |
| **Authentication**    | Google Sign-In, Local Auth         |
| **Storage**           | SharedPreferences, Secure Storage  |
| **Content Rendering** | Flutter HTML, Flutter Markdown     |
| **Image Handling**    | Cached Network Image, Image Picker |
| **Routing**           | GoRouter 16.2.2                    |
| **Utilities**         | Intl, URL Launcher, Flutter SVG    |
| **IDE**               | VS Code, Android Studio, Xcode     |

---

## 📦 Prerequisites

Before you begin, ensure you have the following installed:

### Required

- **Flutter SDK** (3.7.2 or later) — [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK** (included with Flutter)
- **Android Studio** (for Android development) or **Xcode** (for iOS development)
- **Git**

### Recommended

- **VS Code** with Flutter extension
- **Chrome DevTools** for debugging
- **Android Emulator** or physical Android device
- **iOS Simulator** or physical iOS device

### Verification

Verify your Flutter installation:

```bash
flutter doctor
```

Ensure all checks pass (or note any warnings for platform-specific setup).

---

## 🔧 Environment Setup

### 1. Clone the Repository

```bash
git clone https://bitbucket.org/ThrisRH/MDD-client.git
cd MDD-client/mdd-app-int
```

### 2. Fetch Flutter Dependencies

```bash
flutter clean
flutter pub get
```

### 3. Environment Configuration

The project uses `.env` files for environment-specific configuration.

**For Development:**

- File: `.env.development`
- Used when running `flutter run --flavor development -t lib/main-development.dart`

**For Production:**

- File: `.env.production`
- Used when building release APK/IPA

Create or verify `.env.development` and `.env.production` files in the project root with necessary API endpoints and configurations:

```bash
# Example .env.development
API_BASE_URL=https://api-dev.mddblog.local
API_TIMEOUT=30
LOG_LEVEL=debug

# Example .env.production
API_BASE_URL=https://api.mddblog.com
API_TIMEOUT=30
LOG_LEVEL=error
```

### 4. (Optional) Generate Flutter Launcher Icons

If you've updated the app icon, regenerate platform-specific icons:

```bash
flutter pub run flutter_launcher_icons
```

---

## 🚀 Installation & Setup Guide

### Step 1: Install Dependencies

```bash
cd mdd-app-int
flutter pub get
```

### Step 2: Set Up Android Development

**Android Studio Setup:**

1. Open **Android Studio**
2. Go to **Tools > SDK Manager**
3. Install **Android SDK Platform** (API 28+)
4. Install **Android SDK Build Tools** (latest version)
5. Accept licenses:
   ```bash
   flutter doctor --android-licenses
   ```

**Local Properties (if needed):**

```bash
# Run once to auto-detect Android SDK
flutter doctor -v
```

### Step 3: Set Up iOS Development (macOS only)

**Xcode Setup:**

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
```

**Install iOS dependencies:**

```bash
cd ios
pod install
cd ..
```

### Step 4: Verify Setup

Run the setup doctor check:

```bash
flutter doctor
```

**Expected Output:**

- ✅ Flutter SDK
- ✅ Dart SDK
- ✅ Android toolchain
- ✅ Xcode (for iOS)
- ✅ Android emulator (or device available)

---

## 📲 Running the Application

### Development Mode (Android)

```bash
flutter run --debug --flavor development -t lib/main-development.dart
```

### Development Mode (iOS)

```bash
flutter run --debug --flavor development -t lib/main-development.dart -d ios
```

### Development Mode (Web)

```bash
flutter run -d chrome --dart-define=FLAVOR=development -t lib/main-development.dart
```

### Release Build (Android)

```bash
flutter build apk --release --flavor production -t lib/main-production.dart
```

### Release Build (iOS)

```bash
flutter build ios --release --flavor production -t lib/main-production.dart
```

### Run on Specific Device

```bash
# List all devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

### Enable Hot Reload

Once the app is running, press:

- **`r`** — Hot reload (fast, preserves app state)
- **`R`** — Full restart (slow, resets app state)
- **`q`** — Quit

---

## 📁 Project Structure

```
mdd-app-int/
├── lib/                          # Main Dart source code
│   ├── main-development.dart     # Dev entry point
│   ├── main-production.dart      # Prod entry point
│   ├── app.dart                  # App configuration
│   ├── config/                   # Configuration files (API, theme)
│   ├── controllers/              # GetX controllers (state management)
│   ├── middleware/               # Route middleware
│   ├── models/                   # Data models
│   ├── services/                 # API & business logic services
│   ├── src/
│   │   ├── views/                # Screen/page components
│   │   ├── widgets/              # Reusable UI widgets
│   │   └── routes/               # Route definitions
│   ├── theme/                    # Theme & styling
│   └── utils/                    # Utility functions
├── assets/                       # Images, icons, fonts
│   ├── banner/
│   ├── fonts/
│   ├── icons/
│   └── svg/
├── android/                      # Android native code
├── ios/                          # iOS native code
├── web/                          # Web platform configuration
├── test/                         # Unit & widget tests
├── pubspec.yaml                  # Dependencies & metadata
└── analysis_options.yaml         # Lint rules
```

---

## ⚡ Performance Optimizations

The app implements several high-impact performance improvements:

### 1. Image Caching & Placeholders

- Uses `cached_network_image` for efficient image caching
- `ImageSkeleton` loading placeholders reduce perceived latency

### 2. SliverList Implementation

- Blog lists and FAQ sections use `SliverList` for efficient scrolling
- Reduces memory overhead with large lists

### 3. Optimized State Management

- GetX controllers with minimal rebuild scope
- `Obx` reactivity narrowed to specific reactive variables
- Avoid rebuilding entire widget trees on state changes

### 4. Widget Extraction

- Blog details split into three focused widgets:
  - `BlogDetailsContainer` — main content
  - `RelativePost` — related posts
  - `LeaveComment` — comments section
- Reduces rebuild footprint per widget

### 5. Reusable Pagination

- `PaginationBar` widget used across all paginated lists
- Centralized pagination logic in controllers

---

## 💻 Development Workflow

### Code Style & Linting

Run the analyzer to check for issues:

```bash
flutter analyze
```

Fix issues automatically where possible:

```bash
dart fix --apply
```

### Testing

Run widget and unit tests:

```bash
flutter test
```

Run tests with coverage:

```bash
flutter test --coverage
```

### Hot Reload & Debugging

1. **Hot Reload** (preserves state):

   ```bash
   r  # in terminal where flutter run is active
   ```

2. **Debug Mode** (with breakpoints):

   - Set breakpoints in VS Code
   - Press `F5` or click "Debug & Run"

3. **Profiling**:
   ```bash
   flutter run --profile
   # Then open DevTools: flutter pub global run devtools
   ```

### Committing Changes

Follow Git workflow:

```bash
git checkout -b feature/your-feature-name
git add .
git commit -m "feat: description of changes"
git push origin feature/your-feature-name
# Open Pull Request on Bitbucket
```

---

## 🐛 Troubleshooting

### Flutter Doctor Issues

**Issue**: `Android SDK not found`

```bash
# Solution: Set ANDROID_HOME environment variable
export ANDROID_HOME=$HOME/Library/Android/sdk
flutter doctor --android-licenses
```

**Issue**: `Xcode not found` (macOS)

```bash
# Solution: Install Xcode
xcode-select --install
sudo xcode-select --reset
```

### Build Issues

**Issue**: `Gradle build failed`

```bash
# Solution: Clean and rebuild
flutter clean
flutter pub get
flutter pub upgrade
flutter run
```

**Issue**: `CocoaPods error` (iOS)

```bash
# Solution: Update pods
cd ios
rm -rf Pods
pod install --repo-update
cd ..
flutter run
```

### Runtime Errors

**Issue**: `MissingPluginException`

```bash
# Solution: Rebuild app
flutter clean
flutter run
```

**Issue**: `Certificate error` (HTTPS)

- Verify `.env` file contains correct `API_BASE_URL`
- Check network connectivity
- Verify API server is running and accessible

### Device Issues

**Issue**: Device not detected

```bash
# Restart daemon
adb kill-server
adb start-server
flutter devices
```

**Issue**: iOS simulator not starting

```bash
# Kill simulator and restart
killall "Simulator"
open -a Simulator
flutter run -d ios
```

---

## 🤝 Contributing

This is an **intern project**, and contributions follow BITELLE Co., Ltd. guidelines.

### Before Contributing

1. Create a **feature branch** from `develop`:

   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Follow the **code style**:

   - Run `flutter analyze` and fix warnings
   - Use meaningful variable/function names
   - Add comments for complex logic

3. **Test your changes**:

   ```bash
   flutter test
   flutter analyze
   ```

4. **Commit with clear messages**:
   ```bash
   git commit -m "feat: add new feature description"
   # or
   git commit -m "fix: resolve bug description"
   ```

### Pull Request Process

1. Push your branch to Bitbucket
2. Open a **Pull Request** to `develop` branch
3. Ensure all checks pass (CI/CD pipeline)
4. Request review from team leads
5. Merge after approval

### Code Review Checklist

- ✅ Follows project style guide
- ✅ No analyzer warnings
- ✅ Tests added/updated
- ✅ Documentation updated
- ✅ No breaking changes to public APIs

---

## 📚 Additional Resources

- **Flutter Documentation**: https://flutter.dev/docs
- **Dart Language Guide**: https://dart.dev/guides
- **GetX Documentation**: https://pub.dev/packages/get
- **Flutter Performance**: https://flutter.dev/docs/perf
- **Material Design 3**: https://m3.material.io

---

## 📞 Support & Contact

For questions or issues related to this project:

- **Team Lead**: Assigned team member
- **Company**: BITELLE Co., Ltd.
- **Repository**: https://bitbucket.org/ThrisRH/MDD-client
- **Branch**: `develop` (main development branch)

---

## 📄 License

This project is proprietary software developed for BITELLE Co., Ltd. All rights reserved.

---

## 🎓 Learning Objectives

By working on this project, interns will learn:

✅ **Flutter & Dart** — Build cross-platform mobile apps  
✅ **GetX State Management** — Efficient state handling  
✅ **REST APIs & Dio** — HTTP client and API integration  
✅ **Authentication** — OAuth, JWT tokens, and biometric auth  
✅ **Performance Optimization** — Image caching, lazy loading, memory management  
✅ **Git Workflow** — Branching, commits, and pull requests  
✅ **CI/CD Pipelines** — Automated testing and deployment  
✅ **Code Quality** — Linting, testing, and best practices

---

**Last Updated**: November 2025  
**Version**: 1.0.0  
**Status**: Active Development
