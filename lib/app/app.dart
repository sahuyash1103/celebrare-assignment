import 'package:celebrare/pages/home_page.dart';
import 'package:flutter/material.dart';

class CelebrareApp extends StatelessWidget {
  const CelebrareApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Celebrare',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.teal,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: Colors.grey[700],
            fontSize: 22,
            fontWeight: FontWeight.w500,
            fontFamily: 'Diphylleia',
          ),
          bodySmall: TextStyle(
            color: Colors.grey[700],
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'Diphylleia',
          ),
        ),
        useMaterial3: false,
      ),
      home: const HomePage(),
    );
  }
}
