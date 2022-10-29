// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomHorizontalSpacing extends StatelessWidget {
  final double value;
  const CustomHorizontalSpacing({Key? key, required this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: MediaQuery.of(context).size.width/value);
  }
}
