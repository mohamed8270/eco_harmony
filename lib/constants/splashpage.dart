// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:eco_harmony/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Get.toNamed("authenticationtypepage");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ewhite,
      body: SafeArea(
        child: Center(
          child: SvgPicture.network(
            'https://www.svgrepo.com/show/270564/ecology-plant.svg',
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }
}
