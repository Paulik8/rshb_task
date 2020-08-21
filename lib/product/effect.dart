import 'package:fish_redux/fish_redux.dart';
import 'package:rshb_test/detail/action.dart';
import 'package:rshb_test/imageLoader.dart';
import 'package:rshb_test/product/action.dart';
import 'package:rshb_test/product/models/cachedImage.dart';
import 'package:rshb_test/product/models/catalogModel.dart';
import 'package:rshb_test/product/state.dart';
import 'package:rshb_test/widgets/converters.dart';

Effect<ProductState> buildEffect() {
  return combineEffects(<Object, Effect<ProductState>>{
    Lifecycle.initState: _onInit,
  });
}

Future _onInit(Action action, Context<ProductState> ctx) async {
  final products = ctx.state.catalog.products;
  var cachedImages = <String, CachedImage>{};
  await Future.forEach(products, (Product el) async { 
    final image = isImageFromAssets(el.image) ? await getImageFileFromAssets(el.image) : await getImageFileFromNetwork(el.image);
    cachedImages[el.image] = image;
    ctx.dispatch(ProductActionCreator.cacheLoadedImage(cachedImages));
    ctx.broadcast(DetailActionCreator.imageLoaded(<String, dynamic>{
      'url': el.image,
      'image': image,
    }));
  });
  
}