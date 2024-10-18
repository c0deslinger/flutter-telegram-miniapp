// ignore_for_file: avoid_print

import 'package:foruai_mini_app/model/create_invoice_response.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// reference: https://core.telegram.org/bots/api
class TelegramBotController extends GetxController {
  final String botToken = '7801729215:AAGeIL7Rn6wng0odM_5-C5LGgtQ13URv5Yk';
  final String telegramApiUrl = 'https://api.telegram.org/bot';

  // Mengirim Invoice ke pengguna
  Future<CreateInvoiceResponse?> generateInvoice({
    required String title,
    required String description,
    required String payload,
    required String currency,
    required int priceAmount,
    required String priceLabel,
  }) async {
    final url = Uri.parse('$telegramApiUrl$botToken/createInvoiceLink');
    CreateInvoiceResponse? createInvoiceResponse;

    final priceObject = [
      {
        'label': priceLabel,
        'amount': priceAmount,
      }
    ];

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'description': description,
        'payload': payload,
        'provider_token': "",
        'currency': currency,
        'prices': priceObject,
        "photo_url":
            "https://storage.googleapis.com/untukmu/foru/ForU_Cat_BotStart.jpeg",
        "photo_width": 150,
        "photo_height": 150,
      }),
    );

    print('Response: ${response.body}');

    if (response.statusCode == 200) {
      createInvoiceResponse =
          CreateInvoiceResponse.fromJson(jsonDecode(response.body));
    } else {
      print('Gagal mengirim invoice: ${response.body}');
    }

    return createInvoiceResponse;
  }
}
