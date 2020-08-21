import 'package:fish_redux/fish_redux.dart';
import 'package:rshb_test/home/action.dart';
import 'package:rshb_test/home/state.dart';

Reducer<HomeState> buildReducer() {
  return asReducer(<Object, Reducer<HomeState>>{
    HomeAction.loadData: _loadData,
    HomeAction.setChangedTab: _setChangedTab,
    HomeAction.setFavouriteStatusProducts: _setFavouriteStatusProducts,
  });
}

HomeState _loadData(HomeState state, Action action) {
  return state.clone()
    ..catalog = action.payload['catalog']
    ..currentProducts = action.payload['currentProducts'];
}

HomeState _setChangedTab(HomeState state, Action action) {
  return state.clone()
    ..currentIndex = action.payload;
}

HomeState _setFavouriteStatusProducts(HomeState state, Action action) {
  return state.clone()
    ..catalog = action.payload['catalog']
    ..currentProducts = action.payload['currentProducts'];
}