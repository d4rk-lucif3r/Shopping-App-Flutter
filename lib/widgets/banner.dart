import 'package:flutter/material.dart';

Widget wrapWithBanner(Widget child) {
  return Banner(
    child: child,
    location: BannerLocation.topStart,
    message: 'LuCiFeR',
    color: Colors.blue.withOpacity(0.5),
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12.0,
      letterSpacing: 1.0,
      fontFamily: 'OpenSans',

    ),
    textDirection: TextDirection.ltr,
  );
} 