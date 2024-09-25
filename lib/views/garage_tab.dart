import 'package:flutter/material.dart';
import 'package:foruai_mini_app/controller/coin_controller.dart';
import 'package:foruai_mini_app/controller/telegram_controller.dart';
import 'package:get/get.dart';
import 'package:shake_detector/shake_detector.dart';

class GarageTab extends GetView<CoinController> {
  GarageTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoinController>(
      builder: (coinController) => ShakeDetectWrap(
        onShake: () {
          coinController.incrementCoins(amount: 2);
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GetBuilder<TelegramController>(builder: (telegramController) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/captain.jpg'),
                              radius: 30.0,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Capt. ' +
                                  (telegramController.telegramData?['user']
                                          ?['username'] ??
                                      'Unknown'),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        (telegramController.telegramData != null &&
                                telegramController.telegramData!['user'] !=
                                    null)
                            ? Column(
                                children: [
                                  Text(
                                    telegramController.telegramData?['user']
                                            ?['first_name'] ??
                                        'Unknown',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    telegramController.telegramData?['user']
                                                ?['id']
                                            .toString() ??
                                        'Unknown',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    );
                  }),
                  const SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      const HudView(
                        label: 'Earn Per tap: 2',
                        icon: Icon(
                          Icons.monetization_on,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      HudView(
                        label: 'HP ${coinController.spaceshipLevel.value}',
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      const HudView(
                        label: 'Coin per sec: +1',
                        icon: Icon(
                          Icons.monetization_on,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                coinController.incrementCoins(amount: 2);
              },
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: 350.0,
                curve: Curves.easeInOut,
                child: Image.asset(
                  'assets/spaceship.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.monetization_on, color: Colors.amber),
                      const SizedBox(width: 8),
                      Text(
                        'Coins: ${coinController.coins.value}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      coinController.upgradeSpaceship(context);
                    },
                    child: Text(
                        '${'Buy HP (-${coinController.upgradeCost}'} coins)'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HudView extends StatelessWidget {
  const HudView({Key? key, required this.label, required this.icon})
      : super(key: key);

  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            icon,
            const SizedBox(height: 8),
            Text(label,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
