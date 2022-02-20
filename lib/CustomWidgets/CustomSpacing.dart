// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomSpacing extends StatelessWidget {
  final double value;
  const CustomSpacing({Key? key, required this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height/value);
  }
}
