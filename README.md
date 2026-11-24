# ToDo App (Flutter & Firebase)

A modern, cross-platform To-Do application built with Flutter, Riverpod for state management, and Firebase for authentication.

## 🚀 Features

- **User Authentication**: Secure email & password sign-in / registration powered by Firebase Authentication and `firebase_ui_auth`.
- **Task Management**:
  - Add new tasks quickly via input prompt.
  - Inline editing: tap any task to edit its title directly.
  - Reorderable list: drag and drop tasks to prioritize your day.
  - Mark tasks as completed or active with interactive checkboxes.
  - Delete tasks when finished.
- **State Management**: Built using Riverpod (`NotifierProvider` and `StateProvider`) for clean, reactive, and predictable state transitions.
- **Cross-Platform**: Ready for Android, iOS, Web, macOS, Linux, and Windows.

---

## 🛠️ Tech Stack & Architecture

- **Framework**: [Flutter](https://flutter.dev/) (SDK: `^3.10.3`)
- **Language**: [Dart](https://dart.dev/)
- **State Management**: [Riverpod](https://riverpod.dev/) (`hooks_riverpod`, `riverpod_annotation`, `riverpod_generator`)
- **Backend & Auth**:
  - [Firebase Core](https://firebase.google.com/) (`firebase_core`)
  - [Firebase Auth](https://firebase.google.com/docs/auth) (`firebase_auth`, `firebase_ui_auth`)
  - [Cloud Firestore](https://firebase.google.com/docs/firestore) (`cloud_firestore`)

---

## 📂 Project Structure

```text
lib/
├── firebase_options.dart   # Generated Firebase configuration per platform
├── data.dart               # Models (ToDo) and Riverpod providers (toDoProvider, editingIndexProvider)
├── login.dart              # Authentication screen (Firebase UI Auth StreamBuilder)
├── homepage.dart           # Main ToDo dashboard, task list, inline editor, and input controls
└── main.dart               # App entrypoint initializing Firebase and ProviderScope
```

---

## 🏁 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed (SDK `>=3.10.3`).
- A configured [Firebase project](https://firebase.google.com/docs/flutter/setup).

### Installation & Setup

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd flutter_application_2
   ```

2. **Install Flutter dependencies**:
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**:
   Ensure your Firebase credentials are appropriately configured:
   - Run the FlutterFire CLI if you need to reconfigure:
     ```bash
     flutterfire configure
     ```
   - Make sure your Android `google-services.json` and platform credentials are valid.

4. **Run Code Generation** *(if modifying annotations)*:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

5. **Run the Application**:
   ```bash
   flutter run
   ```

---

## 🧪 Testing & Analysis

- Run the analyzer:
  ```bash
  flutter analyze
  ```
- Run tests:
  ```bash
  flutter test
  ```
