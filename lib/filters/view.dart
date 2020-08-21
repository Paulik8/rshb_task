import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:rshb_test/colors.dart';
import 'package:rshb_test/filters/action.dart';
import 'package:rshb_test/filters/state.dart';
import 'package:rshb_test/product/models/catalogModel.dart';
import 'package:rshb_test/widgets/filterDesign.dart';

Widget buildView(FilterState state, Dispatch dispatch, ViewService viewService) {
  
  final categories = state.catalog.categories;
  
  Widget _buildFilterItem(Category item) =>
    FilterDesign(
      dispatch: dispatch,
      item: item,
    );

    List<Widget> _buildSortFilter() =>
      List<Widget>()
        ..add(_buildFilterItem(
          Category(
            id: 0,
            icon: 'assets/icons/categories/sort.png',
            title: 'Сортировать'
          )
        )
      ); 
  
  List<Widget> _buildCategories() {
    if (categories == null || categories.isEmpty) {
      return List();
    } else {
      return categories.map((e) => _buildFilterItem(e)).toList();
    }
  }

  List<Widget> _buildFilters() =>
    _buildSortFilter()
      ..addAll(_buildCategories());
  
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: 
        _buildFilters(),
    )
  );

}