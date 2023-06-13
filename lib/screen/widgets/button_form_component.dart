import 'package:flutter/material.dart';

import 'package:rounded_loading_button/rounded_loading_button.dart';

class ComponentButtonForm extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? buttonColor;
  final RoundedLoadingButtonController controller;
  final String label;
  final Color? labelColor;
  final double? labelFontSize;

  final double width;

  const ComponentButtonForm({
    super.key,
    required this.onPressed,
    required this.controller,
    required this.label,
    this.buttonColor = Colors.green,
    this.labelColor = Colors.white,
    this.labelFontSize = 20,
    this.width = 280,
  });
  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      controller: controller,
      width: width,
      onPressed: onPressed,
      color: buttonColor,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 20,
          color: labelColor,
        ),
      ),
    );
  }
}
