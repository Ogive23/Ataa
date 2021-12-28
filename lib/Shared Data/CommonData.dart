import 'package:ataa/GeneralInfo.dart';
import 'package:flutter/material.dart';

class CommonData extends ChangeNotifier {
  int step = Pages.HomeScreen.index;
  List<int> previousSteps = [Pages.HomeScreen.index];

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
