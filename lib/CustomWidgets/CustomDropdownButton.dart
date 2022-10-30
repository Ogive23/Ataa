import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Shared Data/AppTheme.dart';

class CustomDropdownButton extends StatelessWidget {
  final String text;
  // final double iconSize;
  String? selectedValue;
  final onChanged;
  final items;
  final AppTheme appTheme;

  CustomDropdownButton(
      {Key? key, required this.text,
      // required this.iconSize,
      required this.selectedValue,
      required this.onChanged,
      required this.items,
      required this.appTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton(
            hint: Text(
              text,
              style: appTheme.themeData.primaryTextTheme.headline5,
            ),
            isExpanded: true,
            icon: const Flexible(
                child: Icon(Icons.arrow_drop_down,
                    color: Color.fromRGBO(127, 127, 127, 1.0))),
            style: appTheme.themeData.primaryTextTheme.headline5,
            // iconSize: iconSize,
            value: selectedValue,
            onChanged: onChanged,
            items: items),
        buttonColor: Colors.black,
      ),
    );
  }
}
