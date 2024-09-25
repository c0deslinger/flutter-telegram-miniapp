import 'package:get/get.dart';

class GameplayController extends GetxController {
  bool isGameOver = false;

  void gameOver() {
    isGameOver = true;
    update();
  }
}
