// ignore_for_file: deprecated_member_use, file_names

import 'package:eco_harmony/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInTypeButton extends StatelessWidget {
  const LogInTypeButton({
    super.key,
    required this.icnLink,
    required this.logintxt,
    required this.onTap,
    required this.selected,
  });

  final String icnLink;
  final String logintxt;

  final void Function(String) onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: () {
        onTap(logintxt);
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: screenSize.height * 0.15,
        width: screenSize.width * 0.35,
        decoration: BoxDecoration(
          color: selected ? eblue : eblack.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.network(
              icnLink,
              height: 38,
              width: 38,
              color: selected ? ewhite : eblack,
            ),
            const Gap(20),
            Text(
              logintxt,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: selected ? ewhite : eblack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
