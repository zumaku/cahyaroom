import 'package:cahyaroom/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (user?.photoUrl != null)
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user!.photoUrl!),
              ),
            SizedBox(height: 20),
            Text(
              user?.displayName ?? 'No Name',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              user?.email ?? 'No Email',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Spacer(),
            Padding(padding: EdgeInsets.all(10), child: ElevatedButton(
              onPressed: () async {
                await authProvider.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Center(child: Text('Logout')),
            )),
            Text(
              'Made with ❤️ by zumaku',
              style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
            ),
            SizedBox(height: 10),
            Text(
              '© 2025 zumaku',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            SizedBox(height: 10),
          ],
        )));
  }
}
