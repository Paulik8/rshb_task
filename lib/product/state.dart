import 'package:fish_redux/fish_redux.dart';
import 'package:rshb_test/home/state.dart';

import 'models/cachedImage.dart';
import 'models/catalogModel.dart';

class ProductState implements Cloneable<ProductState> {

  CatalogModel catalog;
  List<Product> currentProducts;
  Map<String, CachedImage> cachedImages;

  @override
  ProductState clone() => ProductState()
    ..catalog = catalog
    ..currentProducts = currentProducts
    ..cachedImages = cachedImages;
  
}

class ProductConnector extends ConnOp<HomeState, ProductState> {

  @override
  ProductState get(HomeState state) {
    final productState = ProductState();
    productState.catalog = state.catalog;
    productState.currentProducts = state.currentProducts;
    productState.cachedImages = state.cachedImages;
    return productState;
  }

  @override
  void set(HomeState homeState, ProductState productState) {
    homeState.catalog = productState.catalog;
    homeState.currentProducts = productState.currentProducts;
    homeState.cachedImages = productState.cachedImages;
  }

}