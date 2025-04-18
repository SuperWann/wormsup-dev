import 'package:flutter/material.dart ';

import 'package:wormsup_dev/pages/main/monitoringPage.dart';
import 'package:wormsup_dev/pages/main/historyPage.dart';
import 'package:wormsup_dev/pages/main/accountPage.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  // Future<void> signOut() async {
  //   await ProfileViewModel().signOut();
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(builder: (context) => AuthPage()),
  //     (Route<dynamic> route) => false,
  //   );
  // }

  int _currentIndex = 0;

  final List<Widget> _pages = [MonitoringPage(), HistoryPage(), AccountPage()];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_currentIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFF6B4F3B), // warna coklat seperti pada gambar
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavIcon(Icons.monitor_rounded, 0),
                    _buildNavIcon(Icons.history, 1),
                    _buildNavIcon(Icons.person, 2),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    return Container(
      decoration:
          _currentIndex == index
              ? BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(
                  0.2,
                ), // background putih transparan
                borderRadius: BorderRadius.circular(10), // biar rounded dikit
              )
              : null,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: IconButton(
        icon: Icon(
          icon,
          color: _currentIndex == index ? Colors.white : Colors.white70,
        ),
        onPressed: () => _onItemTapped(index),
        iconSize: 30,
      ),
    );
  }
}
