import 'package:cahyaroom/providers/transaction_provider.dart';
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
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.pink,
              scaffoldBackgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.pink), // Warna ikon umum
              appBarTheme: AppBarTheme(
                iconTheme:
                    IconThemeData(color: Colors.pink), // Warna ikon di AppBar
                backgroundColor: Colors.white, // Warna latar belakang AppBar
                titleTextStyle: TextStyle(color: Colors.pink, fontSize: 20),
              ),
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Colors.pink, // Warna kursor
                selectionColor:
                    Color.fromARGB(255, 255, 183, 207), // Warna highlight saat teks dipilih
                selectionHandleColor:
                    Colors.pink, // Warna handle (bulatan kecil)
              ),
            ),
            home: authProvider.user == null ? LoginScreen() : MainScreen(),
          );
        },
      ),
    );
  }
}
