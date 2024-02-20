import 'package:eco_harmony/constants/theme.dart';
import 'package:eco_harmony/types/authenticationbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationTypePage extends StatefulWidget {
  const AuthenticationTypePage({super.key});

  @override
  State<AuthenticationTypePage> createState() => _AuthenticationTypePageState();
}

class _AuthenticationTypePageState extends State<AuthenticationTypePage> {
  void updateSelectedUserType(String userType) {
    setState(() {
      selectedType = userType;
    });
  }

  String selectedType = '';
  void slectedUserTypeNavigation(String userType) {
    setState(() {
      selectedType = userType;
    });

    if (selectedType == 'User') {
      Get.toNamed("userbottomnavbar");
    } else if (selectedType == 'Admin') {
      Get.toNamed("adminbottomnavbar");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ewhite,
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Eco Harmony",
                  style: GoogleFonts.poppins(
                    fontSize: 42,
                    fontWeight: FontWeight.w600,
                    color: eblue,
                  ),
                ),
                const Gap(10),
                Text(
                  "The progressive app which shows the transparen result of municiplaity to the public without any hidinga and provides results",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: eblack.withOpacity(0.3),
                  ),
                ),
                const Gap(30),
                Text(
                  "Please select your user type",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: eblack.withOpacity(0.5),
                  ),
                ),
                const Gap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LogInTypeButton(
                      icnLink:
                          'https://www.svgrepo.com/show/532363/user-alt-1.svg',
                      logintxt: 'User',
                      onTap: (userType) async {
                        slectedUserTypeNavigation(userType);
                        HapticFeedback.lightImpact();
                      },
                      selected: selectedType == 'User',
                    ),
                    const Gap(30),
                    LogInTypeButton(
                      icnLink:
                          'https://www.svgrepo.com/show/504002/police-security-policeman.svg',
                      logintxt: 'Admin',
                      onTap: (userType) async {
                        slectedUserTypeNavigation(userType);
                        HapticFeedback.lightImpact();
                      },
                      selected: selectedType == 'Admin',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
