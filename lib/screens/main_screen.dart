import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'tambah_screen.dart';
import 'arsip_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    TambahScreen(),
    ArsipScreen(),
  ];

  final List<String> _titles = [
    'Home',
    'Tambah',
    'Arsip',
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        automaticallyImplyLeading: false, // Menghilangkan panah kembali
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundImage: NetworkImage(
                  'URL_AVATAR_USER'), // Ganti dengan data dari AuthProvider
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedLabelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        selectedItemColor: Colors.pink, // Warna ikon aktif
        unselectedItemColor: Colors.grey, // Warna ikon tidak aktif
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Tambah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: 'Arsip',
          ),
        ],
      ),
    );
  }
}
