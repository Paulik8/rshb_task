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
  return state.clone()
    ..currentProducts = sortedProducts
    ..activeFilters = action.payload['activeFilters'];
}