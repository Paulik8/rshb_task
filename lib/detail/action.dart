import 'package:fish_redux/fish_redux.dart';
import 'package:rshb_test/product/models/cachedImage.dart';
import 'package:rshb_test/product/models/catalogModel.dart';

enum DetailAction {
  imageLoaded,
  updateCachedImage,
  detailFavouriteButtonTapped,
  setDetailFavouriteStatus,
  backIconTapped,
}

class DetailActionCreator {

  static Action imageLoaded(Map<String, dynamic> args) {
    return Action(DetailAction.imageLoaded, payload: args);
  }

  static Action updateCachedImage(CachedImage image) {
    return Action(DetailAction.updateCachedImage, payload: image);
  }

  static Action detailFavouriteButtonTapped(Map<String, dynamic> args) {
    return Action(DetailAction.detailFavouriteButtonTapped, payload: args);
  }

  static Action setDetailFavouriteStatus(Product product) {
    return Action(DetailAction.setDetailFavouriteStatus, payload: product);
  }

  static Action backIconTapped() {
    return Action(DetailAction.backIconTapped);
  }

}