import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_start_pack/providers.dart';
import 'package:todo_start_pack/view/home_page.dart';

// TODO: add firebase_core package dependency and uncomment the following line
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDMADXJLqsvHYgdM4RiVacVXW7dg-BNPzM",
        authDomain: "flutter-starter-pack-9445c.firebaseapp.com",
        projectId: "flutter-starter-pack-9445c",
        storageBucket: "flutter-starter-pack-9445c.appspot.com",
        messagingSenderId: "316657740005",
        appId: "1:316657740005:web:3cc6b8553848d266758c0c"),
  );

  // Initialize Firebase

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ref.watch(themeModeProvider),
      theme: FlexThemeData.light(
        scheme: FlexScheme.redWine,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 9,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.redWine,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 15,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      home: const MyHomePage(title: 'Todo App'),
    );
  }
}
