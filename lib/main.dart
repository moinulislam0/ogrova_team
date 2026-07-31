import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/route/route_manager.dart';
import 'core/route/routes_name.dart';
import 'core/resource/theme_format.dart';
import 'core/resource/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: getApplicationTheme(),
      darkTheme: getDarkApplicationTheme(),
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: RoutesName.splashRoute,
    );
  }
}
