import 'package:fish_redux/fish_redux.dart';
import 'package:rshb_test/detail/state.dart';
import 'package:rshb_test/detail/view.dart';
import 'effect.dart';
import 'reducer.dart';

class DetailPage extends Page<DetailState, Map<String, dynamic>> {
  DetailPage(): super(
    initState: DetailState.initState,
    view: buildView,
    effect: buildEffect(),
    reducer: buildReducer(),
  );
}