import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoinController extends GetxController {
  var coins = 0.obs;
  var spaceshipLevel = 0.obs;
  int upgradeCost = 5;

  void incrementCoins({int amount = 1}) {
    coins += amount;
    update();
  }

  void upgradeSpaceship(BuildContext context) {
    if (coins.value >= upgradeCost) {
      coins -= upgradeCost;
      spaceshipLevel += 1;
    } else {
      // Get.snackbar('Error', 'Not enough coins to upgrade!');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not enough coins to upgrade!'),
        ),
      );
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      incrementCoins();
    });
  }
}
