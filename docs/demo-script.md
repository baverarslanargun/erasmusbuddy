# Demo Script

## Before the Demo

1. Connect the Android device to the internet.
2. Confirm that Email/Password login is enabled in Firebase Authentication.
3. Confirm that Firestore allows the required authenticated reads and writes.
4. Run the Android application.

## 1. Register

1. Open the Login screen.
2. Tap `Create an account`.
3. Enter a username, email, password, and password confirmation.
4. Continue through the Erasmus information and travel interests steps.
5. Tap `Create account`.

Expected result: Firebase creates the account and the Home screen opens.

Only the email and password are currently used to create the Firebase account. The additional registration fields are part of the current UI and are not stored by the MVP.

## 2. Logout and Login

1. Tap the Logout icon on the Home screen.
2. Confirm logout.
3. Enter the registered email and password.
4. Tap `Login`.

Expected result: The Home screen opens for the authenticated user.

## 3. Add a Travel Idea

1. Tap `Add Travel Idea`.
2. Enter a title.
3. Enter a destination.
4. Enter a duration.
5. Enter a budget.
6. Enter a description.
7. Tap `Share Travel Idea`.

Expected result: A success message appears after Firestore saves the idea, and the form fields are cleared.

## 4. Explore Travel Ideas

1. Return to the Home screen.
2. Tap `Explore Ideas`.
3. Find the newly added travel idea in the list.

Expected result: Firestore travel ideas appear in a scrollable list.

## 5. View Details

1. Tap a travel idea card.
2. Review its title, destination, duration, budget, description, creator ID, and date.
3. Return to the previous screen.

Expected result: The selected Firestore document is displayed on the detail screen.

## 6. View Profile

1. Open `My Profile`.
2. Review the display name, email, shared idea count, and personal travel idea list.
3. Open one of the listed travel ideas.

Expected result: The profile uses the authenticated user ID to show that user's travel ideas.

## 7. Final Logout

1. Tap the Logout icon.
2. Confirm logout.

Expected result: The session ends and the Login screen opens.

## Backup Plan

If Firebase is temporarily unavailable, show the already installed application and explain that Authentication and Firestore require an internet connection. Do not use real personal information in demo accounts.
