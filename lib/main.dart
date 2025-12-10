import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/not_found/not_found_page.dart';
import 'core/localization/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();
}

class MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gose City Tours',
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', ''), Locale('ja', '')],
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        primaryColor: const Color(0xFF00A896),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00A896)),
        fontFamily: 'Roboto', // Default compliant font
      ),
      home: const SplashScreen(),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const NotFoundPage());
      },
    );
  }
}
