import 'package:fish_redux/fish_redux.dart';
import 'package:rshb_test/product/models/catalogModel.dart';

enum HomeAction {
  loadData,
  changeTab,
  setChangedTab,
  productCardTapped,
  favouriteButtonTapped,
  setFavouriteStatusProducts,
}

class HomeActionCreator {

  static Action loadData(Map<String, dynamic> args) {
    return Action(HomeAction.loadData, payload: args);
  }

  static Action changeTab(int index) {
    return Action(HomeAction.changeTab, payload: index);
  }

  static Action setChangedTab(int index) {
    return Action(HomeAction.setChangedTab, payload: index);
  }

  static Action productCardTapped(Product item) {
    return Action(HomeAction.productCardTapped, payload: item);
  }

  static Action favouriteButtonTapped(Map<String, dynamic> args) {
    return Action(HomeAction.favouriteButtonTapped, payload: args);
  }

  static Action setFavouriteStatusProducts(Map<String, dynamic> args) {
    return Action(HomeAction.setFavouriteStatusProducts, payload: args);
  }

}