// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable, deprecated_member_use, unused_local_variable

import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:eco_harmony/constants/theme.dart';
import 'package:eco_harmony/interface/custombutton.dart';
import 'package:eco_harmony/models/recognizationresponse.dart';
import 'package:eco_harmony/reusable/imagepicker.dart';
import 'package:eco_harmony/reusable/imageuploadwidget.dart';
import 'package:eco_harmony/reusable/userinput.dart';
// import 'package:eco_harmony/service/checkservice.dart';
// import 'package:eco_harmony/service/geocoding.dart';
// import 'package:eco_harmony/service/locationcallservice.dart';
import 'package:eco_harmony/service/usermongodb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

class UserPostingPage extends StatefulWidget {
  const UserPostingPage({super.key});

  @override
  State<UserPostingPage> createState() => _UserPostingPageState();
}

class _UserPostingPageState extends State<UserPostingPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController talukController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController issueController = TextEditingController();
  TextEditingController issuedateController = TextEditingController();
  TextEditingController issuewardController = TextEditingController();
  TextEditingController issuedesController = TextEditingController();

  // Date package initialization
  DateTime? selectedFromDate;
  // Image Picker to package initilization
  late ImagePicker _picker;
  // Image Recognization reponse variable
  RecognizationResponse? _response;
  // Service importation
  // Service service = Get.put(Service());
  // // Permission handling Injection
  // PermissionsHandler permissionsHandler = Get.put(PermissionsHandler());
  // // Geo Coding Injection
  // GeocodingLocation geocodingLocation = Get.put(GeocodingLocation());

  // Select Date Function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedFromDate) {
      setState(() {
        selectedFromDate = picked;
        issuedateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize image picker
    _picker = ImagePicker();
    // service.getLocation();
  }

  // Image obtain function
  Future<String?> obtainImage(ImageSource source) async {
    final file = await _picker.pickImage(source: source);
    return file?.path;
  }

  //Upload Image
  Future<String?> uploadImage(String imgPath) async {
    final cloudinary = CloudinaryPublic(
      'dmb6hkclb',
      'xii5qts7',
      cache: false,
    );

    try {
      final response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imgPath,
          resourceType: CloudinaryResourceType.Image,
        ),
      );
      return response.secureUrl;
    } catch (e) {
      // print(e);
      Get.snackbar(
        'Error',
        '$e',
        backgroundColor: ered,
        snackPosition: SnackPosition.BOTTOM,
        colorText: ewhite,
      );
      return null;
    }
  }

  //image path
  void processImageandPath(String imgPath) async {
    setState(() {
      _response = RecognizationResponse(
        imgPath: imgPath,
      );
    });
  }

  MongoController mongoController = Get.put(MongoController());

  Future<void> submitData() async {
    try {
      String? imgUrl;
      if (_response?.imgPath != null) {
        imgUrl = await uploadImage(_response!.imgPath);
        if (imgUrl == null) Exception('Failed to upload Image');
      }

      final uuid = Uuid();
      final userissuepostdata = {
        '_id': uuid.v4(),
        'username': nameController.text,
        'number': numberController.text,
        'email': emailController.text,
        'address': addressController.text,
        'taluk': talukController.text,
        'district': districtController.text,
        'location': locationController.text,
        'issue': issueController.text,
        'issuedate': issuedateController.text,
        'wardno': issuewardController.text,
        'issuedescription': issuedesController.text,
        'image': imgUrl,
      };

      await mongoController.pushData(userissuepostdata);
      Get.toNamed('userbottomnavbar');
    } catch (e) {
      throw Exception('Error while submitting data: $e');
    }
  }

  @override
  void dispose() {
    mongoController.onClose();
    super.dispose();
  }

  // Controller for Map from flutter_map package
  MapController myController = MapController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: ewhite,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.network(
            'https://www.svgrepo.com/show/223783/notes-post-it.svg',
            height: 12,
            width: 12,
            // color: sBlack.withOpacity(0.3),
          ),
        ),
        title: Text(
          "Post Issue",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: eblack,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomButton(
        click: () => submitData(),
        height: screenSize.height * 0.06,
        width: screenSize.width * 0.9,
        boxcolor: eblue,
        txt: "Submit",
        txtcolor: ewhite,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload proof",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: eblack,
                ),
              ),
              const Gap(10),
              ImageUploadWidget(
                txt: _response == null ? "Upload Image" : "Change Image",
                onClick: () async {
                  showDialog(
                    context: context,
                    builder: (context) => imagePickAlert(
                      onCameraPressed: () async {
                        final imgpath = await obtainImage(ImageSource.camera);
                        if (imgpath == null) return;
                        processImageandPath(imgpath);
                        Get.back();
                      },
                      onGalleryPressed: () async {
                        final imgpath = await obtainImage(ImageSource.gallery);
                        if (imgpath == null) return;
                        processImageandPath(imgpath);
                        Get.back();
                      },
                    ),
                  );
                },
              ),
              _response == null
                  ? Text(
                      "**Please upload an image to submit as a proof**",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: ered,
                      ),
                    )
                  : SizedBox(
                      height: screenSize.width,
                      width: screenSize.width,
                      child: Image.file(File(_response!.imgPath)),
                    ),
              const Gap(20),
              Text(
                "User Detail's",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: eblack,
                ),
              ),
              const Gap(10),
              UserInputBox(
                height: screenSize.height * 0.055,
                width: screenSize.width * 0.95,
                icnLink: 'https://www.svgrepo.com/show/491095/user.svg',
                txt: 'Name',
                type: TextInputType.name,
                userController: nameController,
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UserInputBox(
                    height: screenSize.height * 0.055,
                    width: screenSize.width * 0.47,
                    icnLink: 'https://www.svgrepo.com/show/488920/email.svg',
                    txt: 'Email',
                    type: TextInputType.emailAddress,
                    userController: emailController,
                  ),
                  UserInputBox(
                    height: screenSize.height * 0.055,
                    width: screenSize.width * 0.47,
                    icnLink:
                        'https://www.svgrepo.com/show/533284/phone-alt.svg',
                    txt: 'Phone No.',
                    type: TextInputType.number,
                    userController: numberController,
                  ),
                ],
              ),
              const Gap(10),
              UserInputBox(
                height: screenSize.height * 0.2,
                width: screenSize.width * 0.95,
                icnLink: 'https://www.svgrepo.com/show/533170/address-book.svg',
                txt: 'Address',
                type: TextInputType.streetAddress,
                userController: addressController,
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UserInputBox(
                    height: screenSize.height * 0.055,
                    width: screenSize.width * 0.47,
                    icnLink:
                        'https://www.svgrepo.com/show/510853/building-01.svg',
                    txt: 'Taluk',
                    type: TextInputType.streetAddress,
                    userController: talukController,
                  ),
                  UserInputBox(
                    height: screenSize.height * 0.055,
                    width: screenSize.width * 0.47,
                    icnLink:
                        'https://www.svgrepo.com/show/496889/building-4.svg',
                    txt: 'District',
                    type: TextInputType.streetAddress,
                    userController: districtController,
                  ),
                ],
              ),
              // const Gap(10),
              // GestureDetector(
              //   onTap: () async {
              //     await service.getLocation();
              //     myController.move(
              //       LatLng(service.latitude, service.longitude),
              //       18.0,
              //     );
              //     geocodingLocation.getPlacemark(
              //       service.latitude,
              //       service.longitude,
              //     );
              //     myController.latLngToScreenPoint(
              //       LatLng(service.latitude, service.longitude),
              //     );
              //     var message =
              //         "https://www.google.com/maps/search/?api=1&query=${service.latitude},${service.longitude}";
              //     setState(() {
              //       locationController.text = message;
              //     });
              //   },
              //   child: AbsorbPointer(
              //     child: UserInputBox(
              //       height: screenSize.height * 0.055,
              //       width: screenSize.width * 0.95,
              //       icnLink:
              //           'https://www.svgrepo.com/show/532539/location-pin.svg',
              //       txt: 'Location',
              //       type: TextInputType.url,
              //       userController: locationController,
              //     ),
              //   ),
              // ),
              const Gap(20),
              Text(
                "Issue Detail's",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: eblack,
                ),
              ),
              const Gap(10),
              UserInputBox(
                height: screenSize.height * 0.055,
                width: screenSize.width * 0.95,
                icnLink: 'https://www.svgrepo.com/show/379250/report.svg',
                txt: 'Issue or Problem',
                type: TextInputType.text,
                userController: issueController,
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UserInputBox(
                    height: screenSize.height * 0.055,
                    width: screenSize.width * 0.47,
                    icnLink:
                        'https://www.svgrepo.com/show/430557/area-map-marker-line.svg',
                    txt: 'Ward no.',
                    type: TextInputType.text,
                    userController: issuewardController,
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: UserInputBox(
                        height: screenSize.height * 0.055,
                        width: screenSize.width * 0.47,
                        icnLink:
                            'https://www.svgrepo.com/show/524350/calendar.svg',
                        txt: 'Issue date',
                        type: TextInputType.datetime,
                        userController: issuedateController,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              UserInputBox(
                height: screenSize.height * 0.2,
                width: screenSize.width * 0.95,
                icnLink: 'https://www.svgrepo.com/show/379250/report.svg',
                txt: 'Issue Desciption',
                type: TextInputType.text,
                userController: issuedesController,
              ),
              const Gap(100),
            ],
          ),
        ),
      ),
    );
  }
}
