import 'package:fish_redux/fish_redux.dart';
import 'package:rshb_test/filters/action.dart';
import 'package:rshb_test/filters/state.dart';
import 'package:rshb_test/widgets/converters.dart';

Effect<FilterState> buildEffect() {
  return combineEffects(<Object, Effect<FilterState>>{
    FilterAction.sortFilterTapped: _sortFilterTapped,
  });
}

void _sortFilterTapped(Action action, Context<FilterState> ctx) {
  final sorter = ProductSorter();
  final currentProducts = ctx.state.currentProducts;
  var finalProducts;
  final id = action.payload['id'];
  final isActive = action.payload['isActive'];
  final activeFilters = ctx.state.activeFilters;
  if (id != 0) {
    var isSortFilterActive = activeFilters.firstWhere((el) => el == 0, orElse: () => null);
    var areOtherFilters = activeFilters.firstWhere((el) => (el != 0 && el != id), orElse: () => null);
    if (isActive) {
      if (areOtherFilters == null) {
        finalProducts = sorter.sortByCategoryIdAndSortedByFilter(ctx.state.currentProducts, id: id, byRating: isSortFilterActive == null);
      } else {
        finalProducts = sorter.sortByCategoryIdAndSortedByFilter(ctx.state.catalog.products, cProducts: ctx.state.currentProducts, id: id, byRating: isSortFilterActive == null);
      }
    } else {
      if (areOtherFilters == null) {
        finalProducts = isSortFilterActive == null ? sorter.sortByRating(ctx.state.catalog.products) : sorter.sortByPrice(ctx.state.catalog.products);
      } else {
        currentProducts.removeWhere((el) => el.categoryId == id);
        finalProducts = isSortFilterActive == null ? sorter.sortByRating(currentProducts) : sorter.sortByPrice(currentProducts);
      }
    }
  } else {
    if (isActive) {
      finalProducts = sorter.sortByPrice(ctx.state.currentProducts);
    } else {
      finalProducts = sorter.sortByRating(ctx.state.currentProducts);
    }
  }
  if (isActive) {
    activeFilters.add(id);
  } else {
    activeFilters.removeWhere((el) => el == id);
  }
  ctx.dispatch(FilterActionCreator.sortFilterSet(<String, dynamic>{
    'activeFilters': activeFilters,
    'products': finalProducts,
  }));
}