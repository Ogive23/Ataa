// ignore_for_file: file_names

import 'package:ataa/Shared%20Data/AppLanguage.dart';
import 'package:ataa/Shared%20Data/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  static late double h;
  const ErrorMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    h = MediaQuery.of(context).size.height;
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Lottie.asset('assets/animations/38213-error.json', height: h / 10),
            Text(
              message,
              style: appTheme.nonStaticGetTextStyle(
                  1.0,
                  Colors.red[300],
                  appTheme.mediumTextSize(context),
                  FontWeight.normal,
                  1.0,
                  TextDecoration.none,
                  'OpenSans'),
              textAlign: TextAlign.center,
              textDirection: appLanguage.textDirection,
            ),
          ],
        ));
  }
}
