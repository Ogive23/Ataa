// ignore_for_file: file_names

import 'package:ataa/GeneralInfo.dart';
import 'package:flutter/material.dart';

class CommonData extends ChangeNotifier {
  int step = Pages.HomeScreen.index;
  List<int> previousSteps = [Pages.HomeScreen.index];

  changeStep(int step) {
    this.step = step;
    previousSteps.add(step);
    notifyListeners();
  }

  back() {
    previousSteps.removeLast();
    step = previousSteps.last;
    notifyListeners();
  }

  lastStep() {
    return previousSteps.length == 1;
  }

  goHome() {
    previousSteps = [1];
    step = previousSteps.last;
    notifyListeners();
  }

  void refreshPage() {
    notifyListeners();
  }
}
