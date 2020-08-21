import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:rshb_test/product/models/cachedImage.dart';
import 'package:rshb_test/product/models/catalogModel.dart';

class HomeState implements Cloneable<HomeState> {

  CatalogModel catalog;
  List<Product> currentProducts;
  List<int> activeFilters;
  TabController tabController;
  int currentIndex;
  Map<String, CachedImage> cachedImages;

  static HomeState initState(Map<String, dynamic> args) {
    return HomeState()
      ..currentIndex = 0
      ..currentProducts = List()
      ..activeFilters = List()
      ..cachedImages = {};
  }

  @override
  HomeState clone() => HomeState()
    ..catalog = catalog
    ..tabController = tabController
    ..currentIndex = currentIndex
    ..activeFilters = activeFilters
    ..currentProducts = currentProducts
    ..cachedImages = cachedImages;

}