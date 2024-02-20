// ignore_for_file: avoid_print

import 'package:eco_harmony/constants/theme.dart';
import 'package:eco_harmony/service/geocoding.dart';
import 'package:get/get.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:location/location.dart';

class Service extends GetxController {
  final hasCallsuport = true.obs();
  var longitude = 0.0.obs();
  var latitude = 0.0.obs();

  GeocodingLocation geocodingLocation = GeocodingLocation();
  void initState() {
    super.onInit();
  }

  Future<void> makePhonecall(String phoneNumber) async {
    try {
      await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to make phone call: $e',
        backgroundColor: ered,
        colorText: ewhite,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> getLocation() async {
    Location location = Location();
    LocationData locationdata = await location.getLocation();
    latitude = locationdata.latitude ?? 78.0;
    longitude = locationdata.longitude ?? 78.0;
    await geocodingLocation.getPlacemark(latitude, longitude);
  }
}
