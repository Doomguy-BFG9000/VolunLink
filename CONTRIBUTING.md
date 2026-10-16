# 🤝 Contributing to VolunLink

Thank you for your interest in contributing to **VolunLink**! 🎉 We welcome contributions from developers of all experience levels—from first-time open-source contributors to seasoned Flutter engineers.

VolunLink is dedicated to connecting passionate volunteers with non-profit organizations (NGOs) to create tangible social impact. By contributing, you're directly helping us build tools for social good.

---

## 📑 Table of Contents

- [Code of Conduct](#-code-of-conduct)
- [How Can I Contribute?](#-how-can-i-contribute)
  - [Finding "Good First Issues"](#finding-good-first-issues)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Enhancements](#suggesting-enhancements)
- [Development Setup](#-development-setup)
- [Contribution Workflow](#-contribution-workflow)
  - [1. Fork & Clone](#1-fork--clone)
  - [2. Branching Strategy](#2-branching-strategy)
  - [3. Code & Test](#3-code--test)
  - [4. Commit Guidelines](#4-commit-guidelines)
  - [5. Submit a Pull Request](#5-submit-a-pull-request)
- [Coding Standards & Conventions](#-coding-standards--conventions)
- [Community & Support](#-community--support)

---

## 📜 Code of Conduct

We are committed to providing a welcoming, inclusive, and harassment-free environment for everyone. Please be respectful, constructive, and collaborative in all discussions, issues, and pull requests.

---

## 💡 How Can I Contribute?

### Finding "Good First Issues"
If you are new to the project or open source, look for issues tagged with the **`good first issue`** label. These tasks are self-contained and typically require minimal prior knowledge of the full architecture.

👉 **[Browse Good First Issues](https://github.com/AmitKumarKoli67/VolunLink/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22)**

> [!IMPORTANT]
> **Claiming an Issue:** Before you start coding, please comment on the issue stating your intention to work on it (e.g., *"I'd like to work on this issue!"*). Wait until a maintainer assigns the issue to you to prevent overlapping work.

### Reporting Bugs
If you find a bug:
1. Check the [open issues](https://github.com/AmitKumarKoli67/VolunLink/issues) to ensure it hasn't already been reported.
2. If not, open a new issue with:
   - Clear title and steps to reproduce.
   - Expected vs actual behavior.
   - Device/OS and Flutter version (`flutter doctor -v`).
   - Screenshots or video recordings if applicable.

### Suggesting Enhancements
Feature requests are always welcome! Open an issue describing the proposed feature, the problem it solves, and how it aligns with VolunLink's mission.

---

## ⚙️ Development Setup

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`v3.40.0` or higher)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- Android Studio, VS Code, or your preferred IDE with Flutter & Dart plugins installed.
- Android Emulator / iOS Simulator or a physical device connected.

### Verify Environment
Run the following command to ensure your development environment is healthy:
```bash
flutter doctor
```

---

## 🔄 Contribution Workflow

Follow these steps to submit your contributions:

### 1. Fork & Clone
1. Fork the repository to your GitHub account by clicking the **Fork** button at the top right of [VolunLink](https://github.com/AmitKumarKoli67/VolunLink).
2. Clone your fork locally:
   ```bash
   git clone https://github.com/<YOUR-USERNAME>/VolunLink.git
   cd VolunLink
   ```
3. Add the original repository as the `upstream` remote:
   ```bash
   git remote add upstream https://github.com/AmitKumarKoli67/VolunLink.git
   git fetch upstream
   ```

### 2. Branching Strategy
Always create a new branch from `main` with a clear, descriptive name:
```bash
# For a bug fix
git checkout -b fix/issue-12-login-validation

# For a new feature
git checkout -b feat/ngo-share-button

# For documentation
git checkout -b docs/contributing-guide

# For tests
git checkout -b test/validators-unit-tests
```

### 3. Code & Test
1. Install project dependencies:
   ```bash
   flutter pub get
   ```
2. Run the application to verify baseline setup:
   ```bash
   flutter run
   ```
3. Implement your changes following our [Coding Standards](#-coding-standards--conventions).
4. Run static analysis and tests before committing:
   ```bash
   # Format code
   dart format .

   # Check for lint issues and warnings
   flutter analyze

   # Run test suite
   flutter test
   ```

### 4. Commit Guidelines
We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>(<scope>): <subject>
```

**Common Types:**
- `feat`: A new feature or screen
- `fix`: A bug fix
- `docs`: Documentation updates
- `style`: Formatting, missing semicolons, etc. (no functional code changes)
- `refactor`: Refactoring code without adding features or fixing bugs
- `test`: Adding or updating test cases
- `chore`: Maintenance tasks, dependency updates, CI workflows

**Examples:**
```bash
git commit -m "feat(discover): implement native share action on NGO detail screen"
git commit -m "test(core): add unit tests for Validators utility"
git commit -m "fix(auth): prevent empty submission on forgot password form"
```

### 5. Submit a Pull Request
1. Keep your branch updated with upstream:
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```
2. Push your branch to your fork:
   ```bash
   git push origin <your-branch-name>
   ```
3. Go to [https://github.com/AmitKumarKoli67/VolunLink](https://github.com/AmitKumarKoli67/VolunLink) and click **Compare & pull request**.
4. Fill out the PR template thoroughly:
   - Reference the issue you are fixing (e.g., `Fixes #1` or `Closes #2`).
   - Describe what changed and why.
   - Attach screenshots or screen recordings for any UI changes.
5. Wait for review! A maintainer will review your code, run CI checks, and provide feedback or merge your PR.

---

## 🎨 Coding Standards & Conventions

To keep VolunLink's codebase clean and maintainable, please adhere to these standards:

### Project Architecture
VolunLink uses a **feature-first** modular architecture:
```
lib/
├── app/                  # App routing, global theme configurations
│   ├── app.dart
│   └── theme/            # AppColors, AppTextStyles
├── core/                 # Shared widgets, utilities, constants
│   ├── constants/
│   ├── utils/
│   └── widgets/          # Reusable UI components (buttons, input fields)
├── data/                 # Data models, API providers, local storage
└── features/             # Feature modules (modular)
    ├── ngo/              # NGO screens and widgets
    ├── onboarding/       # Welcome and role selection
    ├── shared/           # Common screens (login, signup)
    └── user/             # Volunteer dashboard, explore, profile
```

### Key Guidelines
- **Theme Tokens:** Never hardcode colors or text sizes directly in widgets. Always use `AppColors` (`lib/app/theme/app_colors.dart`) and `AppTextStyles` (`lib/app/theme/app_text_styles.dart`).
- **Reusable Components:** Check `lib/core/widgets/` for existing buttons (`CustomButton`), text fields (`CustomTextField`), and cards before writing new ones from scratch.
- **Null Safety:** Write strict null-safe Dart code. Avoid using `!` (force unwrap) unless absolutely guaranteed.
- **Stateless vs Stateful:** Prefer `StatelessWidget` whenever possible. Use Provider or GetX state controllers for managing state.
- **Comments & Clean Code:** Document public functions, classes, and complex business logic with doc comments (`///`).

---

## 💬 Community & Support

Have questions, need help getting started, or want to discuss an idea before submitting code?
- Open an issue on GitHub with the `question` label.
- Contact the project maintainer: [amitkkoli67@gmail.com](mailto:amitkkoli67@gmail.com)
- Connect on GitHub: [@AmitKumarKoli67](https://github.com/AmitKumarKoli67)

---

<p align="center">
  Thank you for contributing to <b>VolunLink</b> and helping empower volunteer communities! 💙
</p>
