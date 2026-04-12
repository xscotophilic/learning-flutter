import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_store/core/consts/app_variables.dart';
import 'package:my_store/core/theme/app_theme.dart';
import 'package:my_store/features/home/presentation/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppVariables.appName,
      theme: AppTheme.primaryTheme,
      home: const HomePage(),
    );
  }
}
