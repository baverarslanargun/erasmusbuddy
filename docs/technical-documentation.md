# Technical Documentation

## Project Overview

ErasmusBuddy is a Flutter application where Erasmus students can add and explore travel plan ideas shared by other students. Android is the primary platform used for the Firebase-connected version of the project.

## Project Structure

The application uses a simple folder structure:

- `lib/main.dart` initializes Firebase, defines routes, and selects the first screen.
- `lib/models/` contains the `TravelIdea` data model.
- `lib/services/` contains Firebase Authentication and Cloud Firestore operations.
- `lib/screens/` contains the application screens.
- `lib/core/theme/` contains shared colors and theme settings.

The project does not use a complex state management or architecture package. Flutter widgets such as `StreamBuilder`, `FutureBuilder`, and `Form` handle the current MVP flows.

## Firebase

Firebase is configured for Android.

### Firebase Authentication

`AuthService` provides:

- Account registration with email and password
- Login with email and password
- Logout
- Current user access
- Authentication state changes

`AuthGate` listens to the authentication state and displays either the Login screen or the Home screen.

### Cloud Firestore

`TravelIdeaService` uses the `travelIdeas` collection and provides:

- Creating a travel idea
- Listening to all travel ideas
- Fetching one travel idea by document ID

The `TravelIdea` model contains:

- `id`
- `title`
- `destination`
- `description`
- `duration`
- `budget`
- `createdBy`
- `createdAt`

`createdBy` stores the Firebase Authentication user ID. `createdAt` is stored as an ISO 8601 string.

## Navigation

Named routes are defined in `main.dart`. The main user flow is:

1. Login or register
2. Open the Home screen
3. Add a travel idea or explore existing ideas
4. Open a travel idea detail
5. View the Profile screen
6. Logout

## Main Dependencies

- `firebase_core`
- `firebase_auth`
- `cloud_firestore`
- `cupertino_icons`

## Platform Scope

Android is the tested Firebase platform. Web and Windows project folders exist, but Firebase options are currently generated only for Android. Full Firebase behavior on other platforms is outside the current MVP scope.
