import 'package:fish_redux/fish_redux.dart';
import 'package:rshb_test/product/effect.dart';
import 'package:rshb_test/product/reducer.dart';
import 'package:rshb_test/product/state.dart';
import 'package:rshb_test/product/view.dart';

class ProductComponent extends Component<ProductState> {
  ProductComponent(): super(
    view: buildView,
    effect: buildEffect(),
    reducer: buildReducer(),
  );
}