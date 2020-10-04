import 'package:flutter/material.dart';

class CommonData extends ChangeNotifier{
  int step = 1;
  changeStep(int step){
    this.step = step;
    notifyListeners();
  }
}