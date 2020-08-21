import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rshb_test/colors.dart';
import 'package:rshb_test/widgets/converters.dart';

class RatingLabel extends StatelessWidget {

  final num rating;
  final double fontSize;

  const RatingLabel({
    this.rating,
    this.fontSize = 10
  });

  @override
  Widget build(BuildContext context) {

    Color _calculateColor(num rating) {
      if (rating >= 4) {
        return ColorsDesign.ratingLabelExcellent;
      } else if (rating >= 3 && rating < 4) {
        return ColorsDesign.ratingLabelGood;
      } else if (rating == 0) {
        return Colors.grey;
      } else {
        return Colors.red;
      }
    }

    return Container(
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: _calculateColor(rating),
      ),
      child: Align(
        alignment: rating == 0 ? Alignment.topCenter : Alignment.center,
        child: Text(
        convertToUnit(rating),
        style: TextStyle(
          fontFamily: 'SF Pro Display',
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: Colors.white
        ),
      )),
    );
  }

}