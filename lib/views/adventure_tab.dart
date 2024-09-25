// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:foruai_mini_app/controller/coin_controller.dart';
import 'package:foruai_mini_app/views/gameplay.dart';
import 'package:get/get.dart';

class AdventureTab extends StatefulWidget {
  const AdventureTab({super.key});

  @override
  _AdventureTabState createState() => _AdventureTabState();
}

class _AdventureTabState extends State<AdventureTab> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoinController>(builder: (controller) {
      if (controller.spaceshipLevel.value < 1) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/broken.jpg",
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              const Text(
                  "Your spaceship not ready to ship!\nMinimum HP is 5 to play this game.")
            ],
          ),
        );
      }
      return const GameScreen();
    });
  }
}
