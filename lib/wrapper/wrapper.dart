import 'package:eco_harmony/auth/loginpage.dart';
import 'package:eco_harmony/constants/splashpage.dart';
import 'package:eco_harmony/constants/theme.dart';
import 'package:eco_harmony/interface/adminbottomnavbar.dart';
import 'package:eco_harmony/interface/userbottomnavbar.dart';
import 'package:eco_harmony/main.dart';
import 'package:eco_harmony/onboarding/onboardingpage.dart';
import 'package:eco_harmony/types/authenticationtype.dart';
import 'package:eco_harmony/usertypes/admin/pages/adminhomepage.dart';
import 'package:eco_harmony/usertypes/admin/pages/adminprofilepage.dart';
import 'package:eco_harmony/usertypes/user/pages/homepage.dart';
import 'package:eco_harmony/usertypes/user/pages/userpostingpage.dart';
import 'package:eco_harmony/usertypes/user/pages/userprofilepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Eco Harmony',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: eblue),
        useMaterial3: true,
      ),
      routes: {
        "userbottomnavbar": (c) => const UserBottomNavBar(),
        "adminbottomnavbar": (c) => const AdminBottomNavBar(),
        "userhomepage": (c) => const UserHomePage(),
        "userpostpage": (c) => const UserPostingPage(),
        "userprofilepage": (c) => const UserProfilePage(),
        "adminhomepage": (c) => const AdminHomePage(),
        "adminprofilepage": (c) => const AdminProfilePage(),
        "authenticationtypepage": (c) => const AuthenticationTypePage(),
        "loginpage": (c) => const LogInPage(),
      },
      home: isviewed != 0 ? const OnBoardingScreen() : const SplashPage(),
    );
  }
}
