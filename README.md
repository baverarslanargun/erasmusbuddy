# ErasmusBuddy

ErasmusBuddy is a mobile app where students can share and discover travel plan ideas.

The app helps students find inspiration from travel plans created by other students. Users can create their own travel ideas and explore plans shared by others.

---

## Main Idea

A travel plan idea is a user-written trip suggestion. It includes the country, cities, trip duration, places to visit, and a short personal note.
Users can discover these ideas, read the details, save the ones they like, and create their own travel plan ideas.

A travel plan idea includes:
- Title
- Country
- Cities
- Duration
- Places to visit
- Short note or description

## Features

- Register and log in with email & password
- Browse travel plan ideas shared by other students
- View travel plan details (destination, duration, budget, description)
- Create and share a new travel plan idea
- Explore ideas by scrolling through the list
- Logout from the app

## What This App Does Not Do

- It does not create routes automatically.
- It does not provide live navigation.
- It does not find flight, train, or bus tickets.
- It does not calculate the cheapest or shortest route.
- It does not track user location.

---

## Getting Started & Run Instructions

### Prerequisites
1. Install [Flutter SDK](https://docs.flutter.dev/get-started/install) (compatible with SDK version `^3.10.4`).
2. Install [Git](https://git-scm.com/downloads).
3. Set up an Android emulator or physical Android device.

> **Note:** Firebase is already pre-configured for Android. No additional Firebase setup is required to run the app.

### Setup and Running
1. **Clone the repository:**
   ```bash
   git clone https://github.com/baverarslanargun/erasmusbuddy.git
   cd erasmusbuddy
   ```
2. **Install package dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run the application:**
   - Make sure a target device is open/connected.
   - Run the following command:
     ```bash
     flutter run
     ```

---

## Team Git Workflow Rules

To keep the development branch stable, the team adheres to the following workflow:

### Branching Policy
- **`main`:** The release branch. Direct commits are **prohibited**.
- **`development`:** The common integration branch. Direct commits are **prohibited**.
- **Feature Branches:** All work must be done on individual feature branches created off of `development`.
  - Prefix pattern: `feature/<your-feature-name>` (e.g. `feature/home-screen-finalize`)

### Development & Pull Request (PR) Flow
1. Switch to `development` and fetch/pull latest changes:
   ```bash
   git checkout development
   git fetch origin
   git pull origin development
   ```
2. Create your own feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Make changes, test locally, and commit.
4. Publish the branch to origin.
5. Create a Pull Request (PR) on GitHub targeting `development` as the base branch.
6. A peer review and approval is required before the PR can be merged.
7. After merging, update local `development` branch.

### Never Commit Generated Files
The following folders must not be committed to the repository (ensure they are ignored in `.gitignore`):
- `.dart_tool/`
- `build/`
- `windows/flutter/ephemeral/`

---

## Team Members

| Name |
|------|--------|
| Umut Tuncer | 
| Baver Arslanargun | 
| Poyraz Erdoğan |
| Berhan Kemal | 
| Natoli Hunduma Legesse |
