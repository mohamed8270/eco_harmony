// ignore_for_file: deprecated_member_use, unused_local_variable, use_build_context_synchronously, prefer_const_constructors, avoid_print

import 'dart:io';
import 'dart:typed_data';

import 'package:eco_harmony/constants/theme.dart';
import 'package:eco_harmony/service/usermongodb.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class UserIssueDetailPage extends StatefulWidget {
  final int id;
  const UserIssueDetailPage({super.key, required this.id});

  @override
  State<UserIssueDetailPage> createState() => _UserIssueDetailPageState();
}

class _UserIssueDetailPageState extends State<UserIssueDetailPage> {
  MongoController mongoController = Get.put(MongoController());
  double sliderValue = 0;

  Future<Uint8List?> downloadImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print("Failed to download image.");
        return null;
      }
    } catch (e) {
      print("Error downloading image: $e");
      return null;
    }
  }

  Future<File?> saveImageToExternalStorage(
      Uint8List imageData, String fileName) async {
    try {
      // Request permissions
      var status = await Permission.storage.request();
      if (status.isGranted) {
        final directoryPath =
            await ExternalPath.getExternalStoragePublicDirectory(
                ExternalPath.DIRECTORY_DOWNLOADS);
        final filePath = '$directoryPath/$fileName';
        final file = File(filePath);
        await file.writeAsBytes(imageData);
        print("File saved: $filePath");
        return file;
      } else {
        print("Storage permission denied.");
        return null;
      }
    } catch (e) {
      print("Error saving image: $e");
      return null;
    }
  }

  void downloadAndSaveImage(
      BuildContext context, String imageUrl, String fileName) async {
    final imageData = await downloadImage(imageUrl);
    if (imageData != null) {
      final file = await saveImageToExternalStorage(imageData, fileName);
      if (file != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Image saved to ${file.path}")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Failed to save image")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to download image")));
    }
  }

  @override
  void initState() {
    super.initState();
    mongoController.getAllData();
    setInitialSliderValue();
    final MongoController mongoIssueController = Get.find<MongoController>();
    sliderValue = mongoController.getSliderValueByIndex(widget.id);
  }

  void setInitialSliderValue() {
    // Assuming MongoController is already loaded with issues data
    final MongoController mongoIssueController = Get.find<MongoController>();
    String status = mongoIssueController.getStatusByIndex(widget.id);
    sliderValue = mongoIssueController
        .statusToSliderValue(status); // Convert status to slider value
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final MongoController mongoIssueController = Get.find<MongoController>();
    return Scaffold(
      backgroundColor: ewhite,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(14),
          child: SvgPicture.network(
            'https://www.svgrepo.com/show/270564/ecology-plant.svg',
            height: 12,
            width: 12,
          ),
        ),
        title: Text(
          "Issue",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: eblue,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Container(
        height: screenSize.height * 0.07,
        width: screenSize.width,
        decoration: const BoxDecoration(color: ewhite),
        child: Slider(
          value: sliderValue,
          min: 0,
          max: 2,
          divisions: 2,
          label: Get.find<MongoController>().sliderValueToStatus(sliderValue),
          inactiveColor: egrey.withOpacity(0.4),
          activeColor: eblue,
          thumbColor: eblue,
          onChanged: (newrating) {
            setState(() {
              sliderValue = newrating;
            });
            Get.find<MongoController>()
                .updateIssueStatusByIndex(widget.id, newrating);
          },
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Issue Detail's",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: eblack,
                  ),
                ),
                const Gap(10),
                Text(
                  mongoController.allData[widget.id]['issue'].toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: eblue,
                  ),
                ),
                const Gap(5),
                Row(
                  children: [
                    Text(
                      'Ward no. ${mongoController.allData[widget.id]['wardno'].toString()}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: egrey,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      'Date: ${mongoController.allData[widget.id]['issuedate'].toString()}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: egrey,
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Text(
                  mongoController.allData[widget.id]['issuedescription']
                      .toString(),
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: eblack,
                  ),
                ),
                const Gap(30),
                Text(
                  "User Details",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: eblack,
                  ),
                ),
                const Gap(10),
                Text(
                  mongoController.allData[widget.id]['username'].toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: eblue,
                  ),
                ),
                const Gap(2),
                Text(
                  mongoController.allData[widget.id]['email'].toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: egrey,
                  ),
                ),
                const Gap(2),
                Text(
                  mongoController.allData[widget.id]['number'].toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: eblack,
                  ),
                ),
                const Gap(20),
                Text(
                  "Place Detail's",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: eblack,
                  ),
                ),
                const Gap(10),
                Text(
                  mongoController.allData[widget.id]['address'].toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: eblack,
                  ),
                ),
                const Gap(10),
                Row(
                  children: [
                    Text(
                      'Taluk: ${mongoController.allData[widget.id]['taluk'].toString()}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: eblack,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      'District: ${mongoController.allData[widget.id]['district'].toString()}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: eblack,
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                GestureDetector(
                  onTap: () => downloadAndSaveImage(
                    context,
                    mongoController.allData[widget.id]['image'],
                    "downloadedImage.jpg",
                  ),
                  child: Container(
                    width: screenSize.width * 0.4,
                    height: screenSize.height * 0.04,
                    decoration: BoxDecoration(
                      color: eblue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Download Proof',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: ewhite,
                      ),
                    ),
                  ),
                ),
                Text(
                  mongoController.allData[widget.id]['image'].toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: eblue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
