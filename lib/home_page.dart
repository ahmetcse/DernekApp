import 'package:flutter/material.dart';
import 'package:ifmd_app/constants/common_appbar.dart';
import 'package:ifmd_app/constants/navigator_bar.dart';
import 'package:ifmd_app/first_page.dart';
import 'package:ifmd_app/notification_page.dart';
import 'package:ifmd_app/profile.page.dart';

import 'package:ifmd_app/search_page.dart';
import 'package:ifmd_app/settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // Varsayılan olarak ilk sekme seçili

  final List<Widget> _pages = [
    const HomePage(),
    const NotificationPage(),
    const SearchPage(),
    ProfilePage(),
  ];

  void _onNavBarTapped(int index) {
    setState(() {
      _currentIndex = index; // Seçilen sekmeyi güncelle
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "",
        onProfileTap: () {
          const Icon(Icons.sim_card);
          print("Profile tapped from app bar!");
        },
        onSettingsTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SettingsPage()));
        },
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTapped,
      ),
    );
  }
}
