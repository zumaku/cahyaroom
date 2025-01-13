import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/main_screen.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.pink,
              scaffoldBackgroundColor: Colors.pink[50],
              iconTheme: IconThemeData(color: Colors.pink), // Warna ikon umum
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.white), // Warna ikon di AppBar
                backgroundColor: Colors.pink, // Warna latar belakang AppBar
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            home: authProvider.user == null ? LoginScreen() : MainScreen(),
          );
        },
      ),
    );
  }
}
