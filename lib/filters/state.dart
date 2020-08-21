import 'package:fish_redux/fish_redux.dart';
import 'package:rshb_test/home/state.dart';
import 'package:rshb_test/product/models/catalogModel.dart';

class FilterState implements Cloneable<FilterState> {

  CatalogModel catalog;
  List<int> activeFilters;
  List<Product> currentProducts;

  @override
  FilterState clone() => FilterState()
    ..catalog = catalog
    ..activeFilters = activeFilters
    ..currentProducts = currentProducts;
  
}

class FilterConnector extends ConnOp<HomeState, FilterState> {

  @override
  FilterState get(HomeState state) {
    final filterState = FilterState();
    filterState.catalog = state.catalog;
    filterState.activeFilters = state.activeFilters;
    filterState.currentProducts = state.currentProducts;
    return filterState;
  }

  @override
  void set(HomeState homeState, FilterState filterState) {
    homeState.catalog = filterState.catalog;
    homeState.activeFilters = filterState.activeFilters;
    homeState.currentProducts = filterState.currentProducts;
  }

}