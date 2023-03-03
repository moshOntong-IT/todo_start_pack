# Set up Firebase in Flutter App (Mobile and Web)

You can also download this documentation as a PDF file: [Set up Firebase in Flutter App (Mobile and Web)] (
https://drive.google.com/file/d/1B1X2rrxA17sdQdbEIvUxiEvYdX_BhThB/view?usp=sharing)

> But there is easy way to set up Firebase in Flutter App. You can use the Firebase CLI to set up Firebase in your Flutter app.
> Just follow the steps in this tutorial: [Set up Firebase in Flutter App using Firebase CLI] (
> https://www.youtube.com/watch?v=3lsP1jZNqjE) or follow the documentation: [Firebase CLI] (https://firebase.google.com/docs/flutter/setup?platform=web#flutter-setup)

A Starter Pack for todo_start projects.

Firebase is a popular backend platform that provides a suite of services to build mobile and web applications quickly. In this tutorial, we'll show you how to set up Firebase in a Flutter App.

## Prerequisites

- A Flutter development environment
- A Firebase account
- A Firebase project

## Mobile

1. Go to the Firebase console and create a new project.

2. Click on the "Add Firebase to your iOS/Android app" button.

3. Follow the on-screen instructions to download the google-services.json file and add it to the android/app directory of your Flutter project.

4. Add the following dependencies to your pubspec.yaml file:

```yaml
dependencies:
  firebase_core: ^2.7.0
  cloud_firestore: ^4.4.3
```

or run the following command in the terminal:

```bash
flutter pub add firebase_core cloud_firestore
```

5. In the main.dart file, initialize Firebase by adding the following code to the main() method:

```dart
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

## Web

1. Go to the Firebase console and create a new project.

2. Click on the "Add Firebase to your web app" button.

3. Follow the on-screen instructions to copy the configuration code.

4. In the index.html file, add the following code inside the <head> tag:

```html
<script type="module">
  // Import the functions you need from the SDKs you need
  import { initializeApp } from "https://www.gstatic.com/firebasejs/9.17.2/firebase-app.js";
  // TODO: Add SDKs for Firebase products that you want to use
  // https://firebase.google.com/docs/web/setup#available-libraries

  // Your web app's Firebase configuration
  const firebaseConfig = {
    apiKey: "YOUR_API_KEY",
    authDomain: "YOUR_AUTH_DOMAIN",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_STORAGE_BUCKET",
    messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
    appId: "YOUR_APP_ID",
  };

  // Initialize Firebase
  const app = initializeApp(firebaseConfig);
</script>
```

5. Add the following dependencies to your pubspec.yaml file:

```yaml
dependencies:
  firebase_core: ^2.7.0
  cloud_firestore: ^4.4.3
```

or run the following command in the terminal:

```bash
flutter pub add firebase_core cloud_firestore
```

6. In the main.dart file, initialize Firebase by adding the following code to the main() method:

```dart
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "YOUR_API_KEY",
      authDomain: "YOUR_AUTH_DOMAIN",
      projectId: "YOUR_PROJECT_ID",
      storageBucket: "YOUR_STORAGE_BUCKET",
      messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
      appId: "YOUR_APP_ID",
    ),
  );
  runApp(MyApp());
}
```
