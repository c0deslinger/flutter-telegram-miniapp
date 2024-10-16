import 'package:flutter/material.dart';
import 'package:foruai_mini_app/controller/telegram_webapp_controller.dart';
import 'package:foruai_mini_app/model/create_invoice_response.dart';
import 'package:get/get.dart';

import '../controller/telegram_bot_controller.dart';

class EarnTab extends StatelessWidget {
  final TelegramBotController telegramPaymentController = Get.find();
  final TelegramWebAppController telegramController = Get.find();

  EarnTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran Telegram'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Panggil fungsi sendInvoice ketika tombol ditekan
            CreateInvoiceResponse? createInvoiceResponse =
                await telegramPaymentController.generateInvoice(
              title: 'Produk Contoh',
              description: 'Deskripsi produk contoh',
              payload:
                  'unique_payload_${DateTime.now().millisecondsSinceEpoch}',
              currency: 'XTR',
              priceAmount: 1,
              priceLabel: 'Total',
            );

            if (createInvoiceResponse != null && createInvoiceResponse.ok!) {
              //open url
              // js.context.callMethod('open', [createInvoiceResponse.result!]);
              telegramController.openInvoice(createInvoiceResponse.result!);
            }
          },
          child: const Text('Pay Telegram Stars'),
        ),
      ),
    );
  }
}
