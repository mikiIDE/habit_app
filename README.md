# Habit Tracker App

A Flutter portfolio app for tracking daily habits, built with Clean Architecture and Riverpod.

## Overview

This app allows users to create, complete, and delete habits. The primary goal of this project was to practice **Clean Architecture**, **state design**, and **separation of concerns** — skills that translate directly to production-level Flutter development.

## Architecture

This project follows Clean Architecture, separating code into four layers with a strict dependency rule: **outer layers depend on inner layers, never the reverse**.

```
┌─────────────────────────────────────┐
│         presentation/               │  UI only — no business logic
│   (HabitListScreen, Notifier)       │
├─────────────────────────────────────┤
│           application/              │  Use cases — one class per action
│  (AddHabit, Complete, Delete, Fetch)│
├─────────────────────────────────────┤
│             domain/                 │  Core — entities and repository contract
│    (Habit, HabitStatus, interface)  │
├─────────────────────────────────────┤
│          infrastructure/            │  Data — concrete repository implementation
│  (SharedPreferencesHabitRepository) │
└─────────────────────────────────────┘
         Dependency direction: inward ↑
```

## Layer Responsibilities

### domain/
The heart of the app. Contains the `Habit` entity and the abstract `HabitRepository` interface. This layer has **zero dependencies** on Flutter or any external package — it is pure Dart.

### application/
Contains one Use Case class per user action:
- `AddHabitUseCase` — validates input and creates a new habit
- `FetchHabitUseCase` — retrieves all habits
- `CompleteHabitUseCase` — marks a habit as completed
- `DeleteHabitUseCase` — removes a habit by ID

Each Use Case depends only on the abstract `HabitRepository`, not on any concrete implementation.

### infrastructure/
Contains `SharedPreferencesHabitRepository`, the concrete implementation of `HabitRepository`. Handles serialization (`toJson` / `fromJson`) and persistence. This is the only layer that knows about `shared_preferences`.

### presentation/
Contains the UI (`HabitListScreen`) and the Riverpod `HabitListNotifier`. The screen never calls Use Cases directly — it delegates everything to the Notifier, keeping the widget tree free of business logic.

## Design Decisions

### Why is `HabitRepository` an abstract class?
The UI and Use Cases depend on the **interface**, not the implementation. This means the data source can be swapped (e.g., from `SharedPreferences` to Firestore) without touching any Use Case or UI code. It also makes unit testing possible by substituting a fake repository.

### Why use `enum` for `HabitStatus` instead of `bool`?
A `bool isCompleted` only supports two states. An enum makes it trivial to add new states in the future (e.g., `skipped`, `paused`) without breaking existing code. It also makes conditional UI logic more readable and explicit.

### Why is there no business logic in the UI?
The screen is responsible only for displaying state and forwarding user actions to the Notifier. All rules (e.g., empty title validation) live in the Use Case layer. This separation makes the logic reusable, testable, and easier to reason about.

## Tech Stack

| Technology | Version | Purpose |
|---|---|---|
| Flutter | SDK ^3.10.8 | UI framework |
| Riverpod | ^3.2.1 | State management |
| SharedPreferences | ^2.3.5 | Local persistence |

## Project Structure

```
lib/
├── domain/
│   ├── entity/
│   │   └── habit.dart              # Habit class + HabitStatus enum
│   └── repository/
│       └── habit_repository.dart   # Abstract repository interface
├── application/
│   ├── add_habit_usecase.dart
│   ├── fetch_habit_usecase.dart
│   ├── complete_habit_usecase.dart
│   └── delete_habit_usecase.dart
├── infrastructure/
│   └── shared_preferences_habit_repository.dart
├── presentation/
│   └── habit_list_screen.dart
├── provider/
│   ├── habit_list_notifier.dart
│   ├── habit_repository_provider.dart
│   └── habit_usecase_providers.dart
└── main.dart
```

## Future Improvements

- **Unit tests** for each Use Case using a mock repository
- **Firestore integration** to sync habits across devices (infrastructure swap only — no Use Case changes needed)
- **Habit completion streaks** to track consecutive days
- **Category tagging** for organizing habits by type
