import 'package:ataa/Shared%20Data/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  static late double w, h;
  final TextEditingController controller;
  final String? label;
  final IconData? selectedIcon;
  final Color selectedColor;
  final Color borderColor;
  final bool obscureText;
  final TextInputType keyboardType;
  final String hint;
  final String? error;
  final double width;
  final Function? onChanged;
  final Function? onSubmitted;
  // final bool rightInfo;
  final bool enableFormatters;
  final int? maxLines;
  final int? maxLength;
  final String? helperText;
  final TextStyle? helperStyle;
  static late AppTheme appTheme;
  CustomTextField(
      {required this.controller,
      required this.label,
      this.selectedIcon,
      required this.selectedColor,
      required this.borderColor,
      required this.obscureText,
      required this.keyboardType,
      required this.hint,
      required this.error,
      required this.width,
      this.onChanged,
      this.onSubmitted,
      // required this.rightInfo,
      required this.enableFormatters,
      this.maxLength,
      this.maxLines,
      this.helperText,
      this.helperStyle});
  @override
  Widget build(BuildContext context) {
    appTheme = Provider.of<AppTheme>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Padding(
        padding: EdgeInsets.symmetric(vertical: h / 200),
        child: SizedBox(
          width: width,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            textDirection: TextDirection.ltr,
            maxLines: maxLines,
            textAlign: TextAlign.center,
            style: appTheme.themeData.primaryTextTheme.bodyText1,
            textInputAction: TextInputAction.done,
            onChanged: onChanged != null
                ? (value) {
                    onChanged!(value);
                  }
                : null,
            onSubmitted:
            onSubmitted != null
                ? (value) {
              onSubmitted!(value);
            }
                : null
            ,
            inputFormatters: enableFormatters
                ? [FilteringTextInputFormatter.digitsOnly]
                : null,
            maxLength: maxLength,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
                borderRadius: BorderRadius.circular(25.7),
              ),
              hintText: hint,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10.7),
              ),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(15.0)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(15.0)),
              errorText: error,
              errorStyle: appTheme.themeData.primaryTextTheme.subtitle2!
                  .apply(color: Colors.red),
              errorMaxLines: 2,
              labelStyle: appTheme.themeData.primaryTextTheme.bodyText1,
              hintStyle: appTheme.themeData.primaryTextTheme.subtitle1,
              helperText: helperText,
              helperStyle: helperStyle,
              icon: selectedIcon != null
                  ? Icon(
                      selectedIcon,
                      color: selectedColor,
                      //ToDo: Dynamic number
                      size: selectedIcon == null ? 0 : h / 25,
                    )
                  : SizedBox(),
              labelText: label,
            ),
            keyboardType: keyboardType,
          ),
        ));
  }
}
