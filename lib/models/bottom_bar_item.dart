

import 'package:flutter/material.dart';

class BottomBarItem {
  Widget child;
  String title;
  bool isSelect;
  String bottomIcon;
  bool isEmpty;
  BottomBarItem({required this.child, required this.title, this.isSelect = false, required this.bottomIcon, this.isEmpty = false});
}