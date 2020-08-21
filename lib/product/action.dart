import 'package:fish_redux/fish_redux.dart';

enum ProductAction {
  imageLoaded,
  cacheLoadedImage,
}

class ProductActionCreator {

  static Action imageLoaded(Map<String, dynamic> args) {
    return Action(ProductAction.imageLoaded, payload: args);
  }

  static Action cacheLoadedImage(Map<String, dynamic> args) {
    return Action(ProductAction.cacheLoadedImage, payload: args);
  }
  
}