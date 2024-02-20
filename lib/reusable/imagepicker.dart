import 'package:eco_harmony/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget imagePickAlert({
  void Function()? onCameraPressed,
  void Function()? onGalleryPressed,
}) {
  return AlertDialog(
    title: Text(
      "Pick a source",
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: eblack,
      ),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: SvgPicture.network(
            'https://www.svgrepo.com/show/477023/camera.svg',
            height: 34,
            width: 34,
          ),
          title: Text(
            "Camera",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: eblack,
            ),
          ),
          onTap: onCameraPressed,
        ),
        ListTile(
          leading: SvgPicture.network(
            'https://www.svgrepo.com/show/415202/bmp-files-image.svg',
            height: 34,
            width: 34,
          ),
          title: Text(
            "Gallery",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: eblack,
            ),
          ),
          onTap: onGalleryPressed,
        ),
      ],
    ),
  );
}
