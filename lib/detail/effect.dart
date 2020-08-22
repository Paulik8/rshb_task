import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' as m;
import 'package:rshb_test/detail/action.dart';
import 'package:rshb_test/detail/state.dart';
import 'package:rshb_test/home/action.dart';
import 'package:rshb_test/product/models/catalogModel.dart';

Effect<DetailState> buildEffect() {
  return combineEffects(<Object, Effect<DetailState>>{
    DetailAction.imageLoaded: _imageLoaded,
    DetailAction.detailFavouriteButtonTapped: _detailFavouriteButtonTapped,
    DetailAction.backIconTapped: _backIconTapped,
  });
}

void _imageLoaded(Action action, Context<DetailState> ctx) {
  final url = action.payload['url'];
  if (ctx.state.product.image == url)
    ctx.dispatch(DetailActionCreator.updateCachedImage(action.payload['image']));
}

Future _detailFavouriteButtonTapped(Action action, Context<DetailState> ctx) async {
  final Product product = action.payload['product'];
  final isActive = action.payload['isActive'];
  final changedProduct = product.copyWith(
    isFavourite: isActive
  );
  ctx.dispatch(DetailActionCreator.setDetailFavouriteStatus(changedProduct));
  ctx.broadcast(HomeActionCreator.favouriteButtonTapped(<String, dynamic>{
    'product': product,
    'isActive': isActive
  }));
}

void _backIconTapped(Action action, Context<DetailState> ctx) {
  m.Navigator.pop(ctx.context);
}