# Tapyn - Flutter App

## Overview
**Tapyn** is a simple yet powerful Flutter application designed to create and manage digital profile cards. With Tapyn, users can convert their profile into a card displaying their links as icons. The app also enables sharing the profile through QR codes, which can be scanned by others to save the profile. Once saved, users can view the profile details and interact with the links.

## Features

1. **Add Links to Your Profile:**
   - Users can add multiple links (e.g., social media, websites, portfolios).
   - These links are displayed as small icons on the profile card.

2. **Profile Cards:**
   - User profiles are converted into cards that visually represent the person’s profile, including their name, designation, and links as icons.
   
3. **QR Code Generation:**
   - Tapping the profile card generates a unique QR code for the user's profile.
   - The QR code contains all the profile information and links.

4. **Save Profiles by Scanning QR Codes:**
   - When another user scans the QR code, the profile card is saved on their phone.
   - The saved card includes the name, designation, and icons for all the added links.

5. **Instant Redirection:**
   - Tapping on any link icon in the saved profile card will instantly redirect users to the respective link (social media, website, etc.).

## How It Works

1. **Create Profile:**
   - Add your name, designation, and any links you want to share.
   - The app automatically generates small icons for these links, which are displayed on your profile card.

2. **Share Your Profile:**
   - Tap your profile card to convert it into a QR code.
   - Share the QR code with others to let them scan and save your profile.

3. **Save & Interact with Profiles:**
   - After scanning a QR code, the profile is saved in the app.
   - Users can view the saved profile and tap the link icons to instantly access the associated platforms.

## Screenshots
[Add screenshots of the app in this section, showcasing the profile card, QR code generation, and saving features.]

## Getting Started

### Prerequisites

Before you begin, ensure you have met the following requirements:

- You have Flutter installed on your local machine.
- You have a Firebase account set up for Firebase Authentication and Firebase Storage.

### Installation

Follow these steps to install and run the app:

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/tapyn.git

2. Navigate to the project directory:

    ```bash
    cd tapyn

3. Install the required dependencies:

    ```bash
    flutter pub get

4. Run the app:

    ```bash
    flutter run

### Firebase Setup

1. Go to the Firebase Console.
2. Create a new project.
3. Enable Firebase Authentication for email/password login.
4. Set up Firebase Storage to store profile images.
5. Download the google-services.json file and add it to your project's android/app directory.

### App Architecture

- Frontend: Built using Flutter, making it cross-platform for Android and iOS.
- Backend: Firebase Authentication for login functionality and Firebase Storage for storing profile details.
- QR Code: The app uses the qr_flutter package to generate QR codes for profile sharing.
- Link Handling: The app uses the url_launcher package to handle redirection when icons are clicked.

### Dependencies

- firebase_auth: To authenticate users using Firebase.
- firebase_storage: For storing profile images and other assets.
- qr_flutter: For generating and displaying QR codes.
- url_launcher: To launch links from the profile card.
- provider: For state management within the app.

### Usage
1. Create a Profile:

    - Add your name, designation, and links (social media, website, etc.).

2. Generate a QR Code:

    - Tap on your profile card to generate a QR code that others can scan.

3. Scan & Save Profiles:

    - Scan someone’s QR code to save their profile card on your phone. You can view their profile and access their links by tapping on the icons.

### Contributing
Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are greatly appreciated.

If you have suggestions or want to improve this project, follow these steps:

1. Fork the repository.
2. Create your feature branch `(git checkout -b feature/new-feature)`.
3. Commit your changes `(git commit -m 'Add some feature')`.
4. Push to the branch `(git push origin feature/new-feature)`.
5. Open a Pull Request.

### License
This project is licensed under the MIT License. See the LICENSE file for more information.

