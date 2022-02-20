// ignore_for_file: file_names

import 'package:ataa/Shared%20Data/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrizeContainerRow extends StatelessWidget {
  final String firstWord;
  final String secondWord;
  static late double w, h;
  static late AppTheme appTheme;
  const PrizeContainerRow(
      {Key? key, required this.firstWord,
      required this.secondWord,
      }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    appTheme = Provider.of<AppTheme>(context);
    return Row(
      children: [
        SizedBox(
            width: w / 2 - w / 20,
            child: Text(
              firstWord,
              textAlign: TextAlign.center,
              style: appTheme.themeData.primaryTextTheme.headline4,
            )),
        SizedBox(
            width: w / 2 - w / 20,
            child: Text(
              secondWord,
              textAlign: TextAlign.center,
              style: appTheme.themeData.primaryTextTheme.bodyText2,
            )),
      ],
    );
  }
}
