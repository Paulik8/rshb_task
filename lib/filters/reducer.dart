import 'package:fish_redux/fish_redux.dart';
import 'package:rshb_test/filters/action.dart';
import 'package:rshb_test/filters/state.dart';

Reducer<FilterState> buildReducer() {
  return asReducer(<Object, Reducer<FilterState>>{
    FilterAction.sortFilterSet: _sortFilterSet,
  });
}

FilterState _sortFilterSet(FilterState state, Action action) {
  final sortedProducts = action.payload['products'];
  // final changedCatalog = state.catalog.copyWith(
  //   products: sortedProducts
  // );
  return state.clone()
    // ..catalog = changedCatalog
    ..currentProducts = sortedProducts
    ..activeFilters = action.payload['activeFilters'];
}