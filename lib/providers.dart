import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A provider that manages the theme mode.
/// In this app we use it to switch between light and dark theme.
/// We use the package of riverpod to manage the state of the theme mode.
/// To know more about riverpod, please visit the following link:
/// https://riverpod.dev/
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);
