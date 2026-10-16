# 🤝 VolunLink

[![Flutter](https://img.shields.io/badge/Flutter-3.41.4-blue?logo=flutter&logoColor=white&style=for-the-badge)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Good First Issues](https://img.shields.io/github/issues/AmitKumarKoli67/VolunLink/good%20first%20issue?color=7057ff&label=Good%20First%20Issues&style=for-the-badge)](https://github.com/AmitKumarKoli67/VolunLink/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22)
[![Download APK](https://img.shields.io/badge/Download-Release%20APK-brightgreen?logo=android&logoColor=white&style=for-the-badge)](https://github.com/AmitKumarKoli67/VolunLink/releases/latest/download/volun-link.apk)

**VolunLink** is a modern, responsive mobile application built with Flutter that connects passionate volunteers with non-profit organizations (NGOs) across India to create meaningful real-world impact.

---

## 🌟 Key Features

- **NGO Discovery & Search:** Easily discover active NGOs operating across India, filtering by cause, location, and needs.
- **Follow & Stay Updated:** Follow your favorite NGOs to receive real-time notifications about their campaigns, requirements, and volunteer opportunities.
- **In-App Messaging & Chat:** Directly chat with NGO representatives in-app to coordinate volunteer events or clarify queries.
- **Activity & Contribution Tracking:** Track your volunteer hours and keep a record of all your contributions and certificates.
- **Volunteer & NGO Profiles:** Dedicated profile spaces for volunteers (showing achievements/badges) and NGOs (highlighting trust verification, campaigns, and goals).

---

## 🛠️ Tech Stack & Architecture

- **Core Framework:** [Flutter](https://flutter.dev) (v3.41.4 stable)
- **State Management:** [GetX](https://pub.dev/packages/get) / Provider (Clean state binding and routing)
- **Networking:** [Dio](https://pub.dev/packages/dio) & REST APIs
- **Database / Local Storage:** [Hive](https://pub.dev/packages/hive) & [Shared Preferences](https://pub.dev/packages/shared_preferences) for lightning-fast caching
- **UI Animations:** [Lottie](https://pub.dev/packages/lottie) & [Flutter Animate](https://pub.dev/packages/flutter_animate) for beautiful micro-animations
- **Charts & Data Visualizations:** [FL Chart](https://pub.dev/packages/fl_chart)

### 📂 Project Structure

```
lib/
├── app/                  # App-wide routing, theme, and utility configurations
│   ├── app.dart          # Main application widget
│   └── theme/            # Global custom colors and text styles
├── core/                 # Shared widgets, constants, and utilities
├── data/                 # API providers, models, local DB adapters, and state stores
└── features/             # Feature-specific modules (modular structure)
    ├── ngo/              # NGO specific dashboard and screens
    ├── onboarding/       # Welcome flow and role selection
    ├── shared/           # Shared views (login, register, etc.)
    ├── splash/           # Startup splash animations
    └── user/             # Volunteer specific dashboard, home, discovery, profiles
```

---

## 🚀 Getting Started

Follow these steps to run the application locally on your machine.

### Prerequisites
- Install [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.40.0+ recommended)
- Set up an emulator or connect a physical device with USB debugging enabled.

### Run Locally

1. **Clone the repository:**
   ```bash
   git clone https://github.com/AmitKumarKoli67/VolunLink.git
   cd VolunLink
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

4. **Build release APK:**
   ```bash
   flutter build apk --release
   ```

---

## 🗺️ Project Status & Roadmap

### Project Status
- [x] Basic App Shell & Navigation
- [x] State Management Integration (GetX & Provider)
- [x] Modern UI Theme & Typography
- [/] API Integration for NGO Discovery
- [ ] In-App Chat implementation
- [ ] Push Notifications for campaigns

### Upcoming Milestones
- **Q3 2026:** Verify volunteer hours using geolocation check-in/out.
- **Q4 2026:** Launch NGO crowdfunding and direct item donation requests.
- **Q1 2027:** Implement volunteer certificate generation and LinkedIn sharing.

---

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create! We appreciate all contributions, whether it's fixing bugs, improving docs, or proposing new features.

- Check out our [Contributing Guidelines](CONTRIBUTING.md) for full instructions on setup, code formatting, and PR submission.
- Looking for something to work on? Browse our [Good First Issues](https://github.com/AmitKumarKoli67/VolunLink/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22) to get started quickly.

---

## 📧 Contact & Support

For support, feedback, or partnerships, feel free to reach out:
- **Email:** amitkkoli67@gmail.com
- **Developer Account:** [AmitKumarKoli67](https://github.com/AmitKumarKoli67)

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](https://opensource.org/licenses/MIT) page for details.
