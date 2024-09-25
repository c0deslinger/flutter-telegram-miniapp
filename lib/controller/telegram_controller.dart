import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:js' as js;

class TelegramController extends GetxController {
  Map<String, dynamic>? telegramData;

  @override
  void onInit() {
    super.onInit();
    getTelegramData();
  }

  void getTelegramData() {
    // telegramData = {
    //   "user": {
    //     "id": 123456789,
    //     "first_name": "John",
    //     "last_name": "Doe",
    //     "username": "johndoe",
    //     "photo_url": "https://via.placeholder.com/150",
    //   },
    // };
    try {
      telegramData = initTelegramWebApp();
      if (telegramData != null) {
        print('Telegram Data: $telegramData');
      } else {
        print('Telegram data is null.');
      }
    } catch (e) {
      print('Error retrieving Telegram data: $e');
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
}
