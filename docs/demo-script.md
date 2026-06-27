# Demo Script - ErasmusBuddy Walkthrough

This document outlines the step-by-step user journey script for demonstrating the core user flows of the ErasmusBuddy mobile application.

---

## Demo Step-by-Step Flow

### 1. Register a New Account
- **Initial State:** App starts on the **Login Screen**.
- **Action:**
  1. Tap the **Register** link (or "Don't have an account? Sign up") to navigate to the **Register Screen**.
  2. Enter a new student email address (e.g., `student@test.com`).
  3. Enter a password (minimum 6 characters, e.g., `password123`).
  4. Confirm the password by typing it again.
  5. Tap the **Register** button.
- **Expected Outcome:** User account is created in Firebase Auth and the user is automatically logged in and redirected to the **Home Screen**.

### 2. View the Home Screen
- **Action:** Browse the Home Screen modules.
- **Expected Outcome:**
  - The top bar displays the application title: **ErasmusBuddy**.
  - A friendly welcome section displays "Welcome back, Student" (extracting the display name or email prefix).
  - Quick statistics blocks update dynamically showing:
    - **Total Ideas:** Count of all travel ideas in Firestore.
    - **My Shared Plans:** Count of plans created by the logged-in email.
  - A 2x2 grid of **Quick Actions** cards:
    - *Explore Ideas*
    - *Add Travel Idea*
    - *My Profile*
    - *Erasmus Guide*

### 3. Browse Travel Plan Ideas
- **Action:**
  1. From the Quick Actions grid, tap **Explore Ideas** (or use the navigation cards).
  2. Scroll through the feed of travel plan ideas.
  3. Use the search input box at the top to filter ideas by destination or title.
- **Expected Outcome:** The page displays a clean, scrollable list of travel cards. Results filter in real-time as search text changes.

### 4. Open Travel Plan Details
- **Action:**
  1. Tap on any travel plan item from the list.
  2. Read the full specifications: Title, Destination, Duration, Budget, Places to visit, and description notes.
  3. Tap the **Back Arrow** button in the AppBar to return to the list.
- **Expected Outcome:** Details load immediately and display nicely inside card compartments. Returning to the list restores search state.

### 5. Add a New Travel Idea
- **Action:**
  1. Go to the Home Screen and tap **Add Travel Idea** from the Quick Actions grid.
  2. Fill out the form fields:
     - **Title:** `Roadtrip in Portugal`
     - **Destination:** `Portugal`
     - **Cities:** `Lisbon, Porto, Sintra`
     - **Duration:** `7 Days`
     - **Budget:** `300 EUR`
     - **Places to Visit:** `Belem Tower, Luis I Bridge, Pena Palace`
     - **Description:** `Amazing budget trip for Erasmus students! Highly recommended to try pastel de nata in Lisbon.`
  3. Click **Submit Idea**.
- **Expected Outcome:** The travel plan is validated, mapped to a `TravelIdea` object, written to Cloud Firestore, and the page pops back to the previous screen.

### 6. Verify Statistics and View Profile
- **Action:**
  1. Go to the Home Screen.
  2. Verify that **Total Ideas** and **My Shared Plans** metrics have incremented.
  3. Tap **My Profile** from the Quick Actions grid or use the Profile Icon in the top AppBar.
- **Expected Outcome:** The **Profile Screen** displays your user email, how many plans you have shared, and a list of your specific shared travel plan ideas.

### 7. Log Out
- **Action:**
  1. Return to the Home Screen.
  2. Tap the **Logout** icon (exit door symbol) in the top-right corner of the AppBar.
  3. Confirm the action in the pop-up confirmation dialog by tapping **Logout**.
- **Expected Outcome:** The user session is cleared, and the app safely redirects back to the **Login Screen**.
