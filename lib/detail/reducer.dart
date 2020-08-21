import 'package:fish_redux/fish_redux.dart';
import 'package:rshb_test/detail/action.dart';
import 'package:rshb_test/detail/state.dart';

Reducer<DetailState> buildReducer() {
  return asReducer(<Object, Reducer<DetailState>>{
    DetailAction.updateCachedImage: _updateCachedImage,
    DetailAction.setDetailFavouriteStatus: _setDetailFavouriteStatus,
  });
}

DetailState _updateCachedImage(DetailState state, Action action) {
  return state.clone()
    ..cachedImage = action.payload;
}

DetailState _setDetailFavouriteStatus(DetailState state, Action action) {
  return state.clone()
    ..product = action.payload;
}