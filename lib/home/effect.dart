import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' as m;
import 'package:rshb_test/home/action.dart';
import 'package:rshb_test/home/state.dart';
import 'package:http/http.dart' as http;
import 'package:rshb_test/imageLoader.dart';
import 'package:rshb_test/product/models/cachedImage.dart';
import 'package:rshb_test/product/models/catalogModel.dart';
import 'package:rshb_test/sharedPrefs.dart';
import 'package:rshb_test/widgets/converters.dart';

const url = "https://gist.githubusercontent.com/Paulik8/4a8b3e4f160f93ee8c0b770157c78dd8/raw/7c9d503bd21ba06ada5007d484c3f057e53be363/farmer_json";

Effect<HomeState> buildEffect() {
  return combineEffects(<Object, Effect<HomeState>>{
    Lifecycle.initState: _onInit,
    HomeAction.changeTab: _changeTab,
    HomeAction.productCardTapped: _productCardTapped,
    HomeAction.favouriteButtonTapped: _favouriteButtonTapped,
  });
}

Future _onInit(Action action, Context<HomeState> ctx) async {
  final Object ticker = ctx.stfState;
  ctx.state.tabController = m.TabController(length: 3, vsync: ticker);
  final result = await http.get(url);
  if (result.statusCode == 200) {
    final prefs = SharedPref();
    final sorter = ProductSorter();
    final data = catalogModelFromJson(result.body);
    final sortedProducts = sorter.sortByRating(data.products);
    final modifiedProducts = List<Product>();
    await Future.forEach(sortedProducts, (e) async {
      final value = await prefs.read('product${e.id}');
      print(value);
      if (value != null) {
        e = e.copyWith(
          isFavourite: true
        );
      }
      modifiedProducts.add(e);
    });
    ctx.dispatch(HomeActionCreator.loadData(<String, dynamic>{
      'catalog': data.copyWith(
        products: modifiedProducts
      ),
      'currentProducts': modifiedProducts,
    }));
  }
}

void _changeTab(Action action, Context<HomeState> ctx) {
  ctx.state.tabController.animateTo(action.payload);
  ctx.dispatch(HomeActionCreator.setChangedTab(action.payload));
}

Future _productCardTapped(Action action, Context<HomeState> ctx) async {
  final Product item = action.payload;
  final CachedImage cachedImage = ctx.state.cachedImages[item.image];
  await m.Navigator.pushNamed(ctx.context, 'detail', arguments: <String, dynamic>{
    'item': item,
    'image': cachedImage,
  });
}

Future _favouriteButtonTapped(Action action, Context<HomeState> ctx) async {
  final pref = SharedPref();
  final product = action.payload['product'];
  final isActive = action.payload['isActive'];
  final products = ctx.state.catalog.products;
  final catalogIndex = products.indexWhere((element) => element.id == product.id);
  final changedProduct = products[catalogIndex].copyWith(
    isFavourite: isActive
  );
  products[catalogIndex] = changedProduct;
  final currentProducts = ctx.state.currentProducts;
  final currentProductsIndex = currentProducts.indexWhere((element) => element.id == product.id);
  if (currentProductsIndex != -1) {
    currentProducts[currentProductsIndex] = currentProducts[currentProductsIndex].copyWith(
      isFavourite: isActive
    );
  }
  if (isActive) {
    pref.save("product${changedProduct.id}", changedProduct);
  } else {
    pref.remove("product${changedProduct.id}");
  }
  ctx.dispatch(HomeActionCreator.setFavouriteStatusProducts(<String, dynamic>{
    'catalog': ctx.state.catalog.copyWith(
      products: products
    ),
    'currentProducts': currentProducts,
  }));
}