// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TelegramPaymentController extends GetxController {
  final String botToken = '7801729215:AAHYNaLC86VFnPLBBRAxGx3VW_nrMPPm3e4';
  final String providerToken = 'YOUR_PROVIDER_TOKEN'; //optional
  final String telegramApiUrl = 'https://api.telegram.org/bot';

  // Mengirim Invoice ke pengguna
  Future<void> sendInvoice({
    required int chatId,
    required String title,
    required String description,
    required String payload,
    required String currency,
    required int priceAmount,
    required String priceLabel,
  }) async {
    final url = Uri.parse('$telegramApiUrl$botToken/sendInvoice');

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
        'chat_id': chatId,
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
        "start_parameter": chatId

        // {
        //   "photo_url": "https://storage.googleapis.com/untukmu/foru/ForU_Cat_BotStart.jpeg",
        //   "photo_width": 150,
        //   "photo_height": 150,
        //   "start_parameter":chatId
        // }
      }),
    );

    print('Response: ${response.body}');

    if (response.statusCode == 200) {
      print('Invoice berhasil dikirim.');
    } else {
      print('Gagal mengirim invoice: ${response.body}');
    }
  }

  // Mengirim Invoice ke pengguna
  Future<void> generateInvoice({
    required String title,
    required String description,
    required String payload,
    required String currency,
    required int priceAmount,
    required String priceLabel,
  }) async {
    final url = Uri.parse('$telegramApiUrl$botToken/generate-invoice');

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
      print('Invoice berhasil dikirim.');
    } else {
      print('Gagal mengirim invoice: ${response.body}');
    }
  }

  // Menjawab Shipping Query (jika ada)
  Future<void> answerShippingQuery({
    required String shippingQueryId,
    required bool ok,
    List<dynamic>? shippingOptions,
    String? errorMessage,
  }) async {
    final url = Uri.parse('$telegramApiUrl$botToken/answerShippingQuery');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'shipping_query_id': shippingQueryId,
        'ok': ok,
        'shipping_options': shippingOptions,
        'error_message': errorMessage,
      }),
    );

    if (response.statusCode == 200) {
      print('Shipping query dijawab.');
    } else {
      print('Gagal menjawab shipping query: ${response.body}');
    }
  }

  // Menjawab Pre-Checkout Query
  Future<void> answerPreCheckoutQuery({
    required String preCheckoutQueryId,
    required bool ok,
    String? errorMessage,
  }) async {
    final url = Uri.parse('$telegramApiUrl$botToken/answerPreCheckoutQuery');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'pre_checkout_query_id': preCheckoutQueryId,
        'ok': ok,
        'error_message': errorMessage,
      }),
    );

    if (response.statusCode == 200) {
      print('Pre-Checkout query dijawab.');
    } else {
      print('Gagal menjawab Pre-Checkout query: ${response.body}');
    }
  }

  // Meng-handle update dari Telegram (webhook)
  void handleUpdate(Map<String, dynamic> update) {
    if (update.containsKey('pre_checkout_query')) {
      // Menangani Pre-Checkout Query
      final preCheckoutQuery = update['pre_checkout_query'];
      answerPreCheckoutQuery(
        preCheckoutQueryId: preCheckoutQuery['id'],
        ok: true,
      );
    } else if (update.containsKey('successful_payment')) {
      // Pembayaran berhasil
      final successfulPayment = update['successful_payment'];
      print('Pembayaran berhasil: $successfulPayment');
      // Lakukan tindakan lanjutan seperti mengirim konfirmasi
    }
    // Tambahkan handler lain jika diperlukan
  }
}
