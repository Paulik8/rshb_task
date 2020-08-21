import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:rshb_test/filters/action.dart';
import 'package:rshb_test/product/models/catalogModel.dart';

import '../colors.dart';

class FilterDesign extends StatefulWidget {

  final Category item;
  final Dispatch dispatch;

  const FilterDesign({
    this.item,
    this.dispatch,
  });

  @override
  FilterDesignState createState() => FilterDesignState();

}

class FilterDesignState extends State<FilterDesign> {

  bool _isActive;

  @override
  void initState() {
    _isActive = false;
    super.initState();
  }

  Widget _buildFilterItem(Category item) =>
    Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isActive = !_isActive;
              widget.dispatch(FilterActionCreator.sortFilterTapped(<String, dynamic>{
                'id': item.id,
                'isActive': _isActive,
              }));
            });
          },
          child: Container(
            height: 40,
            width: 40,
            padding: EdgeInsets.all(11),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              border: Border.all(
                color: ColorsDesign.filterBorder,
              ),
              color: !_isActive ? Colors.white : ColorsDesign.ratingLabelExcellent,
            ),
            child: Image.asset(item.icon, fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 8,),
        Container(
          width: 76,
          child: Text(
            item.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: ColorsDesign.commonText,
              letterSpacing: -0.41
            ),
            maxLines: 2,
          )
        ),
        SizedBox(height: 20,)
      ],
    );

  @override
  Widget build(BuildContext context) {
    return _buildFilterItem(widget.item);
  }

}