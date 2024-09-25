import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:js' as js;

class TelegramController extends GetxController {
  String botToken = '7801729215:AAEsRq-0Fj0_UJrp33DwpVVxwaSiGt2J9Aw';

  Map<String, dynamic>? telegramData;
  String? profilePhotoUrl;

  @override
  void onInit() {
    super.onInit();
    getTelegramData();
  }

  void getTelegramData() {
    telegramData = initTelegramWebApp();
    if (telegramData != null) {
      print('Telegram Data: $telegramData');
      // Fetch the profile picture after receiving the Telegram data
      if (telegramData!['user']?['id'] != null) {
        getUserProfilePhoto(telegramData!['user']['id']);
      }
    } else {
      print('Telegram data is null.');
    }
    update();
  }

  // Function to initialize the Telegram WebApp
  static Map<String, dynamic>? initTelegramWebApp() {
    final result = js.context.callMethod('initTelegramWebApp');
    debugPrint("result: $result");
    if (result != null) {
      // Convert JsObject to JSON string and then parse it to a Map
      String jsonString = js.context['JSON'].callMethod('stringify', [result]);
      return jsonDecode(jsonString);
    }

    return null;
  }

  // Function to send data back to Telegram
  static void sendTelegramData(String data) {
    js.context.callMethod('sendTelegramData', [data]);
  }

  // Function to control the MainButton in Telegram
  static void setMainButton(String text, bool isVisible) {
    js.context.callMethod('setMainButton', [text, isVisible]);
  }

  // Function to fetch the user's profile photo from Telegram's API
  Future<void> getUserProfilePhoto(int userId) async {
    try {
      // API endpoint to get the user's profile photos
      final String url =
          'https://api.telegram.org/bot$botToken/getUserProfilePhotos?user_id=$userId&limit=1';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the response body
        final data = jsonDecode(response.body);
        if (data['ok'] == true && data['result']['photos'].isNotEmpty) {
          // Get the photo file ID of the highest resolution picture
          final photos = data['result']['photos'][0];
          final photoFileId = photos.last['file_id'];

          // Get the file URL
          final photoUrl = await getFileUrl(photoFileId);
          profilePhotoUrl = photoUrl;
          update();
        } else {
          print('No profile photos found.');
        }
      } else {
        print('Failed to fetch profile photos: ${response.body}');
      }
    } catch (e) {
      print('Error fetching profile photo: $e');
    }
  }

  // Function to get the file URL for a file_id from Telegram
  Future<String?> getFileUrl(String fileId) async {
    try {
      // API endpoint to get the file path
      final String url =
          'https://api.telegram.org/bot$botToken/getFile?file_id=$fileId';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['ok'] == true) {
          final filePath = data['result']['file_path'];
          // Construct the file URL
          final fileUrl =
              'https://api.telegram.org/file/bot$botToken/$filePath';
          return fileUrl;
        } else {
          print('Failed to fetch file path: ${response.body}');
        }
      } else {
        print('Failed to fetch file path: ${response.body}');
      }
    } catch (e) {
      print('Error fetching file URL: $e');
    }
    return null;
  }
}
