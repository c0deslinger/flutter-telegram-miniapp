// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:foruai_mini_app/controller/coin_controller.dart';
import 'package:get/get.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  final CoinController coinController = Get.find();

  double birdY = 0;
  double initialPosition = 0;
  bool gameStarted = false;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velocity = 3.5;
  // int score = 0;

  double obstacleX = 2;
  double obstacleSize = 50;

  late Timer timer;

  void startGame() {
    gameStarted = true;
    time = 0;
    initialPosition = birdY;
    timer = Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.04;
      height = gravity * time * time + velocity * time;
      setState(() {
        birdY = initialPosition - height;

        if (obstacleX < -1.5) {
          obstacleX += 3;
          obstacleSize = Random().nextDouble() * 100 + 20;
          // score++;
          coinController.coins.value += 100;
        } else {
          obstacleX -= 0.05;
        }

        if (birdY > 1 || birdY < -1) {
          timer.cancel();
          showGameOverDialog();
        }

        if (birdY < -0.4 + obstacleSize / 100 &&
            birdY > -0.4 - obstacleSize / 100 &&
            obstacleX < 0.1 &&
            obstacleX > -0.1) {
          timer.cancel();
          showGameOverDialog();
        }
      });
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Game Over"),
          actions: [
            // FlatButton(
            //   child: Text("Play Again"),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //     resetGame();
            //   },
            // ),
            ElevatedButton(
                onPressed: () {
                  resetGame();
                },
                child: const Text("Play Again"))
          ],
        );
      },
    );
  }

  void resetGame() {
    Navigator.of(context).pop();
    setState(() {
      birdY = 0;
      gameStarted = false;
      time = 0;
      // score = 0;

      coinController.spaceshipLevel.value -= 1;
      obstacleX = 2;
      obstacleSize = 50;
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initialPosition = birdY;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoinController>(builder: (coinController) {
      return GestureDetector(
        onTap: () {
          if (gameStarted) {
            jump();
          } else {
            startGame();
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.blue,
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        alignment: Alignment(0, birdY),
                        duration: const Duration(milliseconds: 0),
                        color: Colors.black,
                        child: const MyBird(),
                      ),
                      Container(
                        alignment: const Alignment(0, -0.3),
                        child: gameStarted
                            ? const Text(
                                "",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              )
                            : const Text(
                                "Tap To Play",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(obstacleX, -0.4),
                        duration: const Duration(milliseconds: 0),
                        child: MyObstacle(
                          size: obstacleSize,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.monetization_on,
                                        color: Colors.amber),
                                    const SizedBox(width: 8),
                                    Text(
                                      coinController.coins.value.toString(),
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.favorite,
                                        color: Colors.red),
                                    const SizedBox(width: 8),
                                    const Text(
                                      "HP ",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      coinController.spaceshipLevel.value
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 15,
                color: Colors.green,
              ),
              Expanded(
                child: Container(
                  color: Colors.brown,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class MyBird extends StatelessWidget {
  const MyBird({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: 50,
        // decoration: BoxDecoration(
        //   color: Colors.yellow,
        //   shape: BoxShape.circle,
        // ),
        child: Image.asset(
          'assets/spaceship.png',
        ));
  }
}

class MyObstacle extends StatelessWidget {
  final double size;

  MyObstacle({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 74, 74, 74),
        shape: BoxShape.circle,
      ),
    );
  }
}
