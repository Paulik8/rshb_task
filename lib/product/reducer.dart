import 'package:fish_redux/fish_redux.dart';
import 'package:rshb_test/product/action.dart';
import 'package:rshb_test/product/state.dart';

Reducer<ProductState> buildReducer() {
  return asReducer(<Object, Reducer<ProductState>>{
    ProductAction.cacheLoadedImage: _cacheLoadedImage,
  });
}

ProductState _cacheLoadedImage(ProductState state, Action action) {
  return state.clone()
    ..cachedImages = action.payload;
}