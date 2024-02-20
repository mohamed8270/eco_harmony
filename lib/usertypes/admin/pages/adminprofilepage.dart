import 'package:eco_harmony/auth/authenticationservice.dart';
import 'package:eco_harmony/constants/theme.dart';
import 'package:eco_harmony/interface/custombutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: ewhite,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: eblack.withOpacity(0.03),
                child: ClipOval(
                  child: Image.network(
                    FirebaseAuth.instance.currentUser!.photoURL!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(20),
              Text(
                FirebaseAuth.instance.currentUser!.displayName!,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: eblue,
                ),
              ),
              const Gap(10),
              Text(
                FirebaseAuth.instance.currentUser!.email!,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: eblack.withOpacity(0.5),
                ),
              ),
              const Gap(20),
              CustomButton(
                height: screenSize.height * 0.06,
                width: screenSize.width * 0.4,
                boxcolor: eblue,
                txt: 'SignOut',
                txtcolor: ewhite,
                click: () {
                  AuthService().signOut();
                  Get.toNamed("loginpage");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
