import 'package:flutter/material.dart';

class SideLayoutModel {
  final Widget panel;
  final SideLayoutButton menuButton;

  SideLayoutModel({
    required this.panel, 
    required this.menuButton
    });
}

class SideLayoutButton {
  final String buttonText;
  final IconData buttonIcon;
  final Color buttonColor;

  SideLayoutButton({
    required this.buttonText, 
    required this.buttonIcon, 
    required this.buttonColor
  });
}