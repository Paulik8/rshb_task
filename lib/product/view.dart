import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:rshb_test/product/state.dart';
import 'package:rshb_test/widgets/productCard.dart';

Widget buildView(ProductState state, Dispatch dispatch, ViewService viewService) {
  
  final products = state.currentProducts;
    if (products == null || products.isEmpty) {
      return Center(
        child: Container(
          child: Text('Нет продуктов'),
        )
      );
    } 

  Widget _buildItems() => 
    GridView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 12, right: 12, bottom: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.65),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final item = products[index];
        return ProductCard(
          item: item,
          image: state.cachedImages[item.image],
          farmer: state.catalog.farmers.firstWhere((element) => element.id == products[index].farmerId, orElse: () => null,).title,
          dispatch: dispatch,
        );
      },
    );

  Widget _buildScreen() =>
    _buildItems();

  return _buildScreen();

}