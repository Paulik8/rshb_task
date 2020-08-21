import 'package:fish_redux/fish_redux.dart';
import 'package:rshb_test/product/models/cachedImage.dart';
import 'package:rshb_test/product/models/catalogModel.dart';

class DetailState implements Cloneable<DetailState> {

  Product product;
  CachedImage cachedImage;

  static DetailState initState(Map<String, dynamic> args) {
    var product;
    var cachedImage;
    if (args != null) {
      if (args['item'] != null)
        product = args['item'];
      if (args['image'] != null) {
        cachedImage = args['image'];
      }
    }
    return DetailState()
      ..product = product
      ..cachedImage = cachedImage;
  }

  @override
  DetailState clone() => DetailState()
    ..cachedImage = cachedImage
    ..product = product;

}