import 'package:flutter/material.dart';

import '../colors.dart';

Text sfProDisplayNormal12Common(String text) =>
  Text(
    text,
    style: TextStyle(
      fontFamily: 'SF Pro Display',
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: ColorsDesign.commonText,
    ),
  );