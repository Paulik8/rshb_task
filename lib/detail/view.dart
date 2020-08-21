import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:rshb_test/colors.dart';
import 'package:rshb_test/detail/action.dart';
import 'package:rshb_test/detail/state.dart';
import 'package:rshb_test/imageLoader.dart';
import 'package:rshb_test/product/models/cachedImage.dart';
import 'package:rshb_test/product/models/catalogModel.dart';
import 'package:rshb_test/widgets/converters.dart';
import 'package:rshb_test/widgets/iconDesign.dart';
import 'package:rshb_test/widgets/productCard.dart';
import 'package:rshb_test/widgets/textCreator.dart';

Widget buildView(DetailState state, Dispatch dispatch, ViewService viewService) {

  final item = state.product;
  final topMargin = MediaQuery.of(viewService.context).size.height / 3.2;

  return DetailScreen(
    item: item,
    image: state.cachedImage,
    topMargin: topMargin,
    dispatch: dispatch,
  );

}

class VariableImage extends StatelessWidget {

  final String url;
  final CachedImage image;
  final EdgeInsets analogPadding;
  final Dispatch dispatch;
  final bool isRectangle;

  const VariableImage({
    this.url,
    this.image,
    this.dispatch,
    this.isRectangle = false,
    this.analogPadding = const EdgeInsets.only(top: 62, left: 110, right: 110),
  });

  Widget _buildWidthMoreHeightItem(BuildContext context) =>
    isRectangle ?
      Container(
        width: MediaQuery.of(context).size.width,
        child: image.image,
      ) :
      Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          image: DecorationImage(
            image: image.image.image,
            fit: BoxFit.fitWidth
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => 
    image == null ?
      Container() :
      (image.widthMoreHeight ? 
        _buildWidthMoreHeightItem(context) :
        Container(
          padding: analogPadding,
          child: image.image,
        )
      );
}

class DetailScreen extends StatelessWidget {

  final Product item;
  final CachedImage image;
  final double topMargin;
  final Dispatch dispatch;

  const DetailScreen({
    this.item,
    this.image,
    this.topMargin,
    this.dispatch,
  });

  Widget _buildImage() =>
    VariableImage(
      url: item.image,
      image: image,
      isRectangle: true,
    );

  Widget _buildText() =>
    Container(
      child: Text(
        item.description,
        style: TextStyle(
          fontFamily: 'SF Pro Display',
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: ColorsDesign.blackText,
          height: 1.5
        ),
      ),
    );

  List<Widget> _buildCharacteristics() =>
    item.characteristics.map((e) => CharacteristicDesign(item: e)).toList();

  Widget _buildContent() =>
    Column(
      children: [
        CompositeTitle(
          item: item,
          fontSize: 20,
          secondaryFontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 12,),
        CompositeRating(
          item: item,
          fontSize: 12,
        ),
        SizedBox(height: 20,),
        PriceDesign(
          item: item,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 54,),
        _buildText(),
        SizedBox(height: 40,),
        Column(
          children: _buildCharacteristics(),
        )
      ],
    );

  Widget _buildDescription(BuildContext context) {
    final initialChildSize = 1 - ((topMargin - 50) / MediaQuery.of(context).size.height);
      return DraggableScrollableSheet(
        initialChildSize: initialChildSize,
        minChildSize: initialChildSize,
        builder: (context, scrollController) {
        return ListView(
          controller: scrollController,
          children: [Container(
            padding: EdgeInsets.only(top: 30, left: 16, right: 16, bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: (image == null || !image.widthMoreHeight) ? [
                BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, -2),
                  color: Colors.grey[200]
                )
              ] : [],
              color: Colors.white,
            ),
            child: _buildContent(),
          )]
          );
      },
      );
  }

  Widget _buildFavouritesIcon() =>
    FavouritesIcon(
      size: 40,
      isActive: item.isFavourite,
      onTap: (isActive) => dispatch(DetailActionCreator.detailFavouriteButtonTapped(<String, dynamic>{
        'product': item,
        'isActive': isActive,
      })),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildImage()
            ),
              _buildDescription(context),
              Positioned(
                top: 60,
                right: 16,
                child: _buildFavouritesIcon(),
              )
          ],
        )
      )
    );
  }

}

class CharacteristicDesign extends StatelessWidget {

  final Characteristic item;

  const CharacteristicDesign({
    this.item,
  });

  Widget _buildLeftText() =>
    Container(
      margin: EdgeInsets.only(bottom: 16),
      child: sfProDisplayNormal12Common(item.title),
    );

  // Widget _buildLine() {
  //   return Row(
  //     children: 
  //       List.generate(100, (index) => index).map((e) => Container(
  //         height: 1,
  //         width: 1,
  //         color: ColorsDesign.commonText,
  //       )).toList(),
  //   );
  // }


  Widget _buildRightText() =>
    Text(
      item.value,
      style: TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: ColorsDesign.blackText,
      ),
    );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLeftText(),
        // _buildLine(),
        _buildRightText(),
      ],
    );
  }

}