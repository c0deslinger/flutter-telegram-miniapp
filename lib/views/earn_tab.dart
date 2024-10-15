import 'package:flutter/material.dart';
import 'package:foruai_mini_app/model/create_invoice_response.dart';
import 'package:foruai_mini_app/widgets/invoice_webview.dart';
import 'package:get/get.dart';

import '../controller/telegram_payment_controller.dart';
import 'dart:js' as js;

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
          onPressed: () async {
            // Panggil fungsi sendInvoice ketika tombol ditekan
            CreateInvoiceResponse? createInvoiceResponse =
                await telegramPaymentController.generateInvoice(
              title: 'Produk Contoh',
              description: 'Deskripsi produk contoh',
              payload:
                  'unique_payload_${DateTime.now().millisecondsSinceEpoch}',
              currency: 'XTR',
              priceAmount: 1000, // Contoh: 1000 sen = $10.00
              priceLabel: 'Total',
            );

            if (createInvoiceResponse != null && createInvoiceResponse.ok!) {
              // _showBottomSheet(context, createInvoiceResponse.result!);

              //open url
              js.context.callMethod('open', [createInvoiceResponse.result!]);
            }
          },
          child: const Text('Pay Telegram Stars'),
        ),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context, String invoiceLink) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 400,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Bayar Produk',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: InvoiceWebview(
                url: invoiceLink,
              ),
            ),
          ],
        ),
      );
    },
  );
}
