import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/event_provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/admin_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
      ],
      child: MaterialApp(
        title: 'Women Leaders Community',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purple,
            brightness: Brightness.light,
          ),
          fontFamily: 'Roboto',
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.purple),
            headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black87),
            bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
            bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
          ),
          cardTheme: CardTheme(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/admin': (context) => const AdminDashboard(),
        },
      ),
    );
  }
}
