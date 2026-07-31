import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// The theme choice used throughout the application.
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
