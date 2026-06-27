# Privacy and Accessibility - ErasmusBuddy

This document details data storage patterns, GDPR and privacy guidelines, data security precautions, and accessibility considerations implemented in the ErasmusBuddy mobile application.

---

## 1. Stored Data and Privacy Guidelines

ErasmusBuddy prioritizes user privacy. The application stores only the essential details necessary to support core travel plan sharing features.

### 1.1 Data Categories
The app interacts with two main types of user-related data:

1. **Authentication Data (Firebase Authentication):**
   - **Fields Stored:** Email address and encrypted password hashes.
   - **Purpose:** Identifies the user, tracks active sessions, and registers new student accounts.
   - **Storage:** Securely managed by Firebase Infrastructure. Passwords are never stored in plaintext on our end or inside client logs.

2. **Travel Plan Ideas (Cloud Firestore):**
   - **Fields Stored:** Title, Country, Cities, Duration, Budget, Places to visit, Creator Email (`createdBy`), and Creation Timestamp (`createdAt`).
   - **Purpose:** Public travel inspiration ideas shared by students for other students.
   - **Storage:** Stored in the `travelIdeas` NoSQL collection.

### 1.2 GDPR & User Control
- **Data Access & Portability:** Users can view all of their shared plans and check their personal statistics on the **My Profile** screen.
- **Session Control:** Users can securely terminate their session at any time by tapping the **Logout** button on the Home Screen.
- **Minimal Collection:** No sensitive metadata (such as device MAC address, phone contacts, exact GPS locations, or cookies) is collected.

---

## 2. Accessibility Considerations

To ensure the application remains usable for a diverse set of students, the frontend adheres to the following accessibility patterns:

### 2.1 Visual Design and Typography
- **Contrast Ratios:** Backgrounds and container colors use accessible pastel and high-contrast palettes (such as indigo/emerald background accents with bold, high-contrast colored text labels).
- **Text Scaling:** Custom widgets use Material Design text styles (like `headlineSmall`, `titleLarge`, `bodyMedium`) that respect default Android and iOS system font scaling settings.
- **Scrollability:** Screens with a lot of contents are wrapped inside `SingleChildScrollView` to prevent layout overflows and rendering clipping when font scaling is active.

### 2.2 Semantic Elements & Screen Readers
- **Semantics:** Employs standard Flutter widgets (like `FilledButton`, `TextButton`, `IconButton`) which automatically translate into native accessibility nodes for screen readers (such as Google TalkBack or Apple VoiceOver).
- **Tooltips:** All action buttons in the AppBar (like the Profile and Logout buttons) have descriptive `tooltip` properties set (e.g. `tooltip: 'My Profile'`), enabling screen readers to read the actions aloud.
- **Input Labels:** Custom text inputs use floating label texts and validator placeholders to clearly declare expectations to assistive technologies.
