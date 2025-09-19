import 'package:flutter/material.dart';
import 'screens/loginscreens.dart';

void main() {
  // Точка входа в приложение
  // runApp принимает корневой виджет приложения
  runApp(const MyApp());
}

// Корневой виджет приложения
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp — «обёртка» приложения:
    // включает тему, навигацию и первый экран
    return MaterialApp(
      debugShowCheckedModeBanner: false, // убираем красный «debug» баннер
      title: 'Flutter Demo', // название приложения
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, // включаем Material Design 3
      ),
      home: const LoginForm(), // указываем домашнюю страницу — форма логина
    );
  }
}
