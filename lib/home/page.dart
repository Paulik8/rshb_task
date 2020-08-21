import 'package:fish_redux/fish_redux.dart';
import 'package:rshb_test/filters/component.dart';
import 'package:rshb_test/filters/state.dart';
import 'package:rshb_test/home/effect.dart';
import 'package:rshb_test/home/reducer.dart';
import 'package:rshb_test/home/state.dart';
import 'package:rshb_test/home/view.dart';
import 'package:rshb_test/product/component.dart';
import 'package:rshb_test/product/state.dart';

class HomePage extends Page<HomeState, Map<String, dynamic>> with SingleTickerProviderMixin {
  HomePage(): super(
    initState: HomeState.initState,
    view: buildView,
    dependencies: Dependencies(
      slots: <String, Dependent<HomeState>> {
        'product': ProductConnector() + ProductComponent(),
        'filter': FilterConnector() + FilterComponent(),
      }
    ),
    effect: buildEffect(),
    reducer: buildReducer(),
  );
}