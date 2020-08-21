import 'package:fish_redux/fish_redux.dart';

enum FilterAction {
  filterByCategoryId,
  sortFilterTapped,
  sortFilterSet,
}

class FilterActionCreator {

  static Action filterByCategoryId(int id) {
    return Action(FilterAction.filterByCategoryId, payload: id);
  }

  static Action sortFilterTapped(Map<String, dynamic> args) {
    return Action(FilterAction.sortFilterTapped, payload: args);
  }

  static Action sortFilterSet(Map<String, dynamic> args) {
    return Action(FilterAction.sortFilterSet, payload: args);
  }

}