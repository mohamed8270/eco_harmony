// ignore_for_file: deprecated_member_use

import 'package:eco_harmony/constants/theme.dart';
import 'package:eco_harmony/usertypes/admin/pages/adminhomepage.dart';
import 'package:eco_harmony/usertypes/admin/pages/adminprofilepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AdminBottomNavBar extends StatefulWidget {
  const AdminBottomNavBar({super.key});

  @override
  State<AdminBottomNavBar> createState() => _AdminBottomNavBarState();
}

class _AdminBottomNavBarState extends State<AdminBottomNavBar> {
  int currentIndex = 0;

  final screens = [
    const AdminHomePage(),
    const AdminProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: eblack.withOpacity(0.3),
              width: 0.15,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: ewhite,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          iconSize: 18,
          currentIndex: currentIndex,
          selectedLabelStyle: const TextStyle(
            color: eblue,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: eblack.withOpacity(0.3),
          selectedItemColor: eblue,
          unselectedLabelStyle: TextStyle(
            color: eblack.withOpacity(0.3),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.network(
                'https://www.svgrepo.com/show/524643/home-angle-2.svg',
                color: eblack.withOpacity(0.4),
              ),
              activeIcon: SvgPicture.network(
                'https://www.svgrepo.com/show/524643/home-angle-2.svg',
                color: eblue,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.network(
                'https://www.svgrepo.com/show/498298/profile.svg',
                color: eblack.withOpacity(0.4),
              ),
              activeIcon: SvgPicture.network(
                'https://www.svgrepo.com/show/498298/profile.svg',
                color: eblue,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
