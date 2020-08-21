import 'package:fish_redux/fish_redux.dart';
import 'package:rshb_test/filters/effect.dart';
import 'package:rshb_test/filters/reducer.dart';
import 'package:rshb_test/filters/state.dart';
import 'package:rshb_test/filters/view.dart';

class FilterComponent extends Component<FilterState> {
  FilterComponent(): super(
    view: buildView,
    effect: buildEffect(),
    reducer: buildReducer(),
  );
}