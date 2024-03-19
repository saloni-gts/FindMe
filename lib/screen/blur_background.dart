import 'dart:ui';

import 'package:flutter/material.dart';

Widget blurView({required Widget child}){

  return BackdropFilter(filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
  child: child,
  );
}