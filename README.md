
---
 
```markdown
# 🛍️ E-Commerce Task App

A modern Flutter e-commerce app designed with **Clean Architecture** and powered by **Riverpod**, **Dio**, and **Hive** (cache memory). This project demonstrates scalable Flutter development using layered architecture and best practices.


<p align="center">
  <img src="https://github.com/SouravBarman001/ecommerce_task/blob/main/screenshots/one.png?raw=true" width="400" alt="Image One"/>
  <img src="https://github.com/SouravBarman001/ecommerce_task/blob/main/screenshots/two.png?raw=true" width="400" alt="Screenshot 2"/>
  <img src="https://github.com/SouravBarman001/ecommerce_task/blob/main/screenshots/three.png?raw=true" width="400" alt="Screenshot 3"/>
</p>



## 📦 Project Overview

This application showcases a simple e-commerce experience with features like product listing, searching, sorting, and state management optimization using Riverpod. Products are fetched from an external API (like FakeStoreAPI), and the UI is polished using  responsive design.

---

## 🚀 Features

- 🔍 **Product Listing**
  - Fetch products from APIs like FakeStoreAPI or DummyJSON.
  - Images cached via `cached_network_image`.

- 🧠 **State Management**
  - Built using **Riverpod 2.0** for powerful and predictable state management.
  - Focus on performance with minimized widget rebuilds.

- 🛒 **Search & Sort**
  - Search by product name.
  - Sort products by price or rating.

- 📦 **Architecture**
  - Embraces **Clean Architecture** principles.
  - Core logic resides in a reusable `core` module.

- 🌐 **Optional: Offline-First Support**
  - Planned support with `hive` and `hive_flutter` for local storage.

- 💅 UI Enhancements
  - Rating system via `flutter_rating_bar`.
  - Responsive layout using `flutter_screenutil`.
  - Loading spinners from `flutter_spinkit`.
  - Percent indicators and badge support for cart/status.

---

## 🛠️ Setup Instructions

### 1. 🚧 Prerequisites
- Flutter SDK ≥ 3.5.4
- Dart
- Android/iOS Emulator or Physical Device

### 2. 📥 Clone Repository
```bash
git clone https://github.com/your-username/ecommerce_task.git
cd ecommerce_task
```

### 3. 📦 Install Dependencies
```bash
flutter pub get
```

### 4. 🧬 Code Generation (for Hive or others)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 5. ▶️ Run the App
```bash
flutter run
```

---

## 🧱 Project Structure

```text
ecommerce_task/
│
├── lib/
│   ├── core/               # Shared utilities, constants, exceptions, etc.
│   ├── features/           # Feature modules
│   │   └── home/           # Home feature
│   │       ├── data/       # Data sources, models, repositories (API/Hive)
│   │       ├── domain/     # Entities, use cases, repository interfaces
│   │       └── presentation/ # UI widgets, screens, and state management
│   └── main.dart           # App entry point
│
├── modules/
│   └── core/               # Local package for shared business logic (if separate from lib/core)
│
└── pubspec.yaml            # Project dependencies and assets

```

---

## 🔧 Dependencies

### Core
- `flutter_riverpod` – State management
- `dio` – HTTP requests
- `dartz` – Functional programming helpers
- `hive`, `hive_flutter` – Local storage
- `cached_network_image`, `shimmer` – Image handling and loading

### UI/UX
- `pinput`, `flutter_screenutil`, `badges`, `flutter_rating_bar`, `percent_indicator`, `flutter_spinkit`

### Dev Tools
- `build_runner`, `hive_generator`, `very_good_analysis`, `flutter_lints`

---

## 🎯 Coming Soon
- Offline caching with Hive
- Cart and Wishlist features
- Improved filtering
- Authentication flow

---

## 🤝 Contributing

Feel free to fork, clone, or submit a pull request. Contributions are welcome!

---
