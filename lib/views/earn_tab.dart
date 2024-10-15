import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/telegram_payment_controller.dart';

class EarnTab extends StatelessWidget {
  final TelegramPaymentController telegramPaymentController = Get.find();

  EarnTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran Telegram'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // // Panggil fungsi sendInvoice ketika tombol ditekan
            // telegramPaymentController.sendInvoice(
            //   chatId: 205853732, // Ganti dengan chat ID pengguna
            //   title: 'Produk Contoh',
            //   description: 'Deskripsi produk contoh',
            //   payload:
            //       'unique_payload_${DateTime.now().millisecondsSinceEpoch}',
            //   // providerToken: 'YOUR_PROVIDER_TOKEN', // Pastikan untuk menambahkan provider token
            //   currency: 'XTR',
            //   priceAmount: 1000, // Contoh: 1000 sen = $10.00
            //   priceLabel: 'Total',
            // );

            // Panggil fungsi sendInvoice ketika tombol ditekan
            telegramPaymentController.generateInvoice(
              title: 'Produk Contoh',
              description: 'Deskripsi produk contoh',
              payload:
                  'unique_payload_${DateTime.now().millisecondsSinceEpoch}',
              currency: 'XTR',
              priceAmount: 1000, // Contoh: 1000 sen = $10.00
              priceLabel: 'Total',
            );
          },
          child: const Text('Pay Telegram Stars'),
        ),
      ),
    );
  }
}
