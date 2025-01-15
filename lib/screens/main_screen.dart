import 'package:cahyaroom/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
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
    'Beranda',
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
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex],
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.pinkAccent,
          ),
        ),
        automaticallyImplyLeading: false, // Menghilangkan panah kembali
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(user!.photoUrl!),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            backgroundColor: const Color.fromARGB(255, 250, 250, 250),
            // backgroundColor: Colors.pinkAccent,
            // backgroundColor: const Color.fromARGB(255, 248, 190, 209),
            selectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              color: Colors.grey,
            ),
            selectedItemColor: Colors.pinkAccent,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  HugeIcons.strokeRoundedHome01,
                  size: 28, // Ukuran ikon disesuaikan
                ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  HugeIcons.strokeRoundedAddSquare,
                  size: 28,
                ),
                label: 'Tambah',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  HugeIcons.strokeRoundedArchive02,
                  size: 28,
                ),
                label: 'Arsip',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
