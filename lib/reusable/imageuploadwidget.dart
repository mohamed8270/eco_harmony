import 'package:dotted_border/dotted_border.dart';
import 'package:eco_harmony/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageUploadWidget extends StatelessWidget {
  const ImageUploadWidget({
    super.key,
    required this.onClick,
    required this.txt,
  });

  final VoidCallback onClick;
  final String txt;

  @override
  Widget build(BuildContext context) {
    final screeSize = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: onClick,
      child: DottedBorder(
        dashPattern: const [8, 4],
        strokeWidth: 1,
        strokeCap: StrokeCap.round,
        child: Container(
          height: screeSize.height * 0.1,
          width: screeSize.width * 0.95,
          decoration: const BoxDecoration(
            color: ewhite,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.network(
                'https://www.svgrepo.com/show/258318/browser-image.svg',
                height: 45,
                width: 45,
              ),
              const Gap(10),
              Text(
                txt,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: eblack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
