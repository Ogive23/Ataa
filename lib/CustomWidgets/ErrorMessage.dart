import 'package:ataa/Shared%20Data/AppLanguage.dart';
import 'package:ataa/Shared%20Data/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  late AppTheme appTheme;
  late AppLanguage appLanguage;
  ErrorMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              '$message',
              style: appTheme.nonStaticGetTextStyle(
                  1.0,
                  Colors.red,
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
