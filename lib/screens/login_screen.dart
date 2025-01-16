import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'main_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Image.asset("assets/images/cahya.png"),
          ),
          SizedBox(height: 20),
          Text(
            'CAHYA ROOM',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.pinkAccent,
            ),
          ),
          SizedBox(height: 20),
          Center(
              child: ElevatedButton(
            onPressed: () async {
              await Provider.of<AuthProvider>(context, listen: false)
                  .signInWithGoogle();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.pinkAccent,
              foregroundColor: Colors.white,
              textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 40), child: Text('Login')),
          ))
        ],
      ),
    );
  }
}
