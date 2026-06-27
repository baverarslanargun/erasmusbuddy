# Privacy and Accessibility

## Stored Data

ErasmusBuddy uses Firebase Authentication and Cloud Firestore.

Firebase Authentication manages:

- User email addresses
- Password-based authentication
- Login sessions
- Firebase user IDs

Passwords are handled by Firebase Authentication. The application does not store passwords in Firestore or local files.

Each travel idea document contains:

- Document ID
- Title
- Destination
- Description
- Duration
- Budget
- Creator user ID
- Creation date

The application does not collect GPS location, contacts, payment details, or transportation data.

## Privacy Notes

ErasmusBuddy is a student MVP. Only data needed for authentication and sharing travel ideas should be collected.

Before the final demo, Firestore security rules should be checked so that access matches the intended authenticated user flow. Test accounts and travel ideas should not contain real private or sensitive information.

The current MVP does not include in-app account deletion, data export, or travel idea deletion. These limitations should be stated clearly during evaluation. Test data can be removed through Firebase Console.

## Accessibility

The interface uses standard Flutter Material widgets, including labeled form fields, buttons, progress indicators, and AppBar tooltips. These widgets provide basic support for Android accessibility services.

Long forms and content screens use scrollable layouts to reduce overflow on smaller devices. Text fields include labels or hints, and validation messages explain missing input.

The project has not completed a formal accessibility audit. Before the demo, the team should check text scaling, color contrast, keyboard visibility, and screen reader labels on the Android test device.
