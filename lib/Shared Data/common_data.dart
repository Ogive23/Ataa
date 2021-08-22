import 'package:flutter/material.dart';

class CommonData extends ChangeNotifier {
  int step = 1;
  List<int> previousSteps = [1];
  bool scaled = false;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  changeStep(int step) {
    this.step = step;
    this.previousSteps.add(step);
    print(previousSteps);
    notifyListeners();
  }

  back() {
    previousSteps.removeLast();
    this.step = previousSteps.last;
    print('removed $previousSteps');
    notifyListeners();
  }

  lastStep() {
    return previousSteps.length == 1;
  }

  goHome() {
    this.previousSteps = [1];
    this.step = previousSteps.last;
    notifyListeners();
  }

  void refreshPage() {
    notifyListeners();
  }
}
