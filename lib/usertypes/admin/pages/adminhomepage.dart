// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:eco_harmony/constants/theme.dart';
import 'package:eco_harmony/service/usermongodb.dart';
import 'package:eco_harmony/usertypes/admin/components/userissuedetailpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  MongoController mongoController = Get.put(MongoController());

  Color getStatusColor(String status) {
    switch (status) {
      case 'Received':
        return eblue; // Example color for 'Received'
      case 'Processing':
        return eyellow; // Example color for 'Processing'
      case 'Completed':
        return egreen; // Example color for 'Completed'
      default:
        return Colors.grey; // Fallback color
    }
  }

  @override
  void initState() {
    super.initState();
    mongoController.getAllData();
    mongoController.getAllData();
    final MongoController mongoIssueController = Get.find<MongoController>();
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
            // color: eblack.withOpacity(0.3),
          ),
        ),
        title: Text(
          "Eco Harmony",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: eblue,
          ),
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
                  "Welcome!",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: eblack,
                  ),
                ),
                Text(
                  "Be the one who makes the system eco-friendly!",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: eblack.withOpacity(0.35),
                  ),
                ),
                const Gap(20),
                Text(
                  "Issue Given",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: eblack,
                  ),
                ),
                const Gap(10),
                SizedBox(
                  height: screenSize.height,
                  width: screenSize.width * 0.95,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: mongoController.allData.length,
                    itemBuilder: (context, index) {
                      final userissuedata = mongoController.allData[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: () {
                            Get.to(
                              UserIssueDetailPage(id: index),
                            );
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Container(
                              // height: screenSize.height * 0.2,
                              width: screenSize.width * 0.95,
                              decoration: BoxDecoration(
                                color: egrey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Container(
                                        width: screenSize.width,
                                        height: screenSize.height * 0.03,
                                        decoration: BoxDecoration(
                                          color: getStatusColor(
                                              mongoIssueController
                                                  .getStatusByIndex(index)),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          mongoIssueController
                                              .getStatusByIndex(index),
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: ewhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      userissuedata["username"].toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: eblack.withOpacity(0.5),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.45,
                                      child: Text(
                                        userissuedata["issue"].toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: eblue,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.45,
                                      child: Text(
                                        'Ward No. ${userissuedata["wardno"].toString()}',
                                        overflow: TextOverflow.visible,
                                        style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: eblack.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      userissuedata["address"].toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: eblack.withOpacity(0.5),
                                      ),
                                    ),
                                    const Gap(10),
                                    SizedBox(
                                      width: screenSize.width * 0.7,
                                      child: Text(
                                        userissuedata["issuedescription"]
                                            .toString(),
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: eblack,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
