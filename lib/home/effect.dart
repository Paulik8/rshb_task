import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' as m;
import 'package:rshb_test/home/action.dart';
import 'package:rshb_test/home/state.dart';
import 'package:http/http.dart' as http;
import 'package:rshb_test/imageLoader.dart';
import 'package:rshb_test/product/models/cachedImage.dart';
import 'package:rshb_test/product/models/catalogModel.dart';
import 'package:rshb_test/widgets/converters.dart';

const url = "https://gist.githubusercontent.com/Paulik8/4a8b3e4f160f93ee8c0b770157c78dd8/raw/5833f430256e8f9fe457f623f0440565c61f14ef/farmer_json";

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
    final sorter = ProductSorter();
    final data = catalogModelFromJson(result.body);
    final sortedProducts = sorter.sortByRating(data.products);
    ctx.dispatch(HomeActionCreator.loadData(<String, dynamic>{
      'catalog': data,
      'currentProducts': sortedProducts,
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
  final product = action.payload['product'];
  final isActive = action.payload['isActive'];
  final products = ctx.state.catalog.products;
  final catalogIndex = products.indexWhere((element) => element.id == product.id);
  products[catalogIndex] = products[catalogIndex].copyWith(
    isFavourite: isActive
  );
  final currentProducts = ctx.state.currentProducts;
  final currentProductsIndex = currentProducts.indexWhere((element) => element.id == product.id);
  if (currentProductsIndex != -1) {
    currentProducts[currentProductsIndex] = currentProducts[currentProductsIndex].copyWith(
      isFavourite: isActive
    );
  }
  ctx.dispatch(HomeActionCreator.setFavouriteStatusProducts(<String, dynamic>{
    'catalog': ctx.state.catalog.copyWith(
      products: products
    ),
    'currentProducts': currentProducts,
  }));
}