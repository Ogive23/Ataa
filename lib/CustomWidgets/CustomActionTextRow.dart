import 'package:ataa/CustomWidgets/CustomHorizontalSpacing.dart';
import 'package:ataa/CustomWidgets/CustomSpacing.dart';
import 'package:flutter/material.dart';

class CustomActionTextRow extends StatelessWidget {
  final String firstText;
  final String secondText;
  final TextStyle firstTextStyle;
  final TextStyle secondTextStyle;
  final String language;

  const CustomActionTextRow(
      {Key? key,
      required this.firstText,
      required this.secondText,
      required this.firstTextStyle,
      required this.secondTextStyle,
      required this.language})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (language == 'En') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            firstText,
            style: firstTextStyle,
          ),
          const CustomHorizontalSpacing(value: 50),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "SignUp");
            },
            child: Text(
              secondText,
              style: secondTextStyle,
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "SignUp");
            },
            child: Text(
              secondText,
              style: secondTextStyle,
            ),
          ),
          CustomHorizontalSpacing(value: 50),
          Text(
            firstText,
            style: firstTextStyle,
          ),
        ],
      );
    }
    ;
  }
}
