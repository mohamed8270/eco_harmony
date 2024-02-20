// ignore_for_file: prefer_final_fields, file_names

import 'package:eco_harmony/constants/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MongoController extends GetxController {
  late Db _db;
  late DbCollection _collection;

  RxList<Map<String, dynamic>> issuesList = RxList<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    _connectToMongo();
    getIssueData();
  }

  // All the Function Below are User Side Rendering
  Future<void> _connectToMongo() async {
    final url = dotenv.env['MONGO_URL'].toString();
    _db = await Db.create(url); // Replace with your MongoDB URI
    await _db.open();
    _collection =
        _db.collection("user_issue_post"); // Replace with your collection name
  }

  Future<void> pushData(Map<String, dynamic> data) async {
    try {
      await _collection.insert(data);
      Get.snackbar(
        "Success",
        "Data pushed to MongoDB successfully",
        backgroundColor: egreen,
        snackPosition: SnackPosition.BOTTOM,
        colorText: ewhite,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to push data: $e",
        backgroundColor: ered,
        snackPosition: SnackPosition.BOTTOM,
        colorText: ewhite,
      );
    }
  }

  RxList<Map<String, dynamic>> _allData = RxList<Map<String, dynamic>>([]);
  List<Map<String, dynamic>> get allData => _allData;

  Future<void> getAllData() async {
    try {
      final data = await _collection.find().toList();
      _allData.value = data;
      update(); // Notify listeners of data change
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to fetch data: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ered,
        colorText: ewhite,
      );
    }
  }

  Future<void> deleteData(String uuid) async {
    try {
      await _collection
          .deleteOne({"_id": uuid}); // Use string-based filter for the UUID
      Get.snackbar(
        "Success",
        "Data deleted successfully",
        backgroundColor: egreen,
        snackPosition: SnackPosition.BOTTOM,
        colorText: ewhite,
      );
      // Optionally, update the UI to reflect the deletion
      await getAllData(); // Fetch updated data
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to delete data: $e",
        backgroundColor: ered,
        snackPosition: SnackPosition.BOTTOM,
        colorText: ewhite,
      );
    }
  }

  Future<void> getIssueData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> fetchedIssues = [
      {'id': 1, 'issue': 'Issue 1', 'status': 'Received'},
      {'id': 2, 'issue': 'Issue 2', 'status': 'Processing'},
      {'id': 3, 'issue': 'Issue 3', 'status': 'Completed'},
    ];

    // issuesList.assignAll([
    //   {'id': 1, 'issue': 'Issue 1', 'status': 'Received'},
    //   {'id': 2, 'issue': 'Issue 2', 'status': 'Processing'},
    //   {'id': 3, 'issue': 'Issue 3', 'status': 'Completed'},
    // ]);

    // Apply saved statuses if they exist
    for (int i = 0; i < fetchedIssues.length; i++) {
      String savedStatus = prefs.getString('issue_status_$i') ??
          'Unknown'; // Default to 'Unknown'
      fetchedIssues[i]['status'] = savedStatus;
    }

    issuesList.assignAll(fetchedIssues);
  }

  // void updateIssueStatusByIndex(int index, double sliderValue) {
  //   if (index < issuesList.length) {
  //     issuesList[index]['status'] = sliderValueToStatus(sliderValue);
  //     issuesList.refresh(); // Notify listeners about the update
  //   }
  // }

  Future<void> updateIssueStatusByIndex(int index, double sliderValue) async {
    if (index < issuesList.length) {
      String status = sliderValueToStatus(sliderValue);
      issuesList[index]['status'] = status;

      // Persist the status in SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'issue_status_$index', status); // Use a unique key for each issue

      issuesList.refresh(); // Notify listeners about the update
    }
  }

  String getStatusByIndex(int index) {
    if (index < issuesList.length) {
      return issuesList[index]['status'] ?? 'Unknown';
    }
    return 'Unknown';
  }

  double getSliderValueByIndex(int index) {
    String status = getStatusByIndex(index);
    return statusToSliderValue(status);
  }

  double statusToSliderValue(String status) {
    switch (status) {
      case 'Received':
        return 0.0;
      case 'Processing':
        return 1.0;
      case 'Completed':
        return 2.0;
      default:
        return 0.0; // Default or fallback value
    }
  }

  String sliderValueToStatus(double value) {
    switch (value.round()) {
      case 0:
        return 'Received';
      case 1:
        return 'Processing';
      case 2:
        return 'Completed';
      default:
        return 'Unknown';
    }
  }

  @override
  void onClose() {
    _db.close();
    super.onClose();
  }
}
