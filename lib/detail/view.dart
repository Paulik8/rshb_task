import 'dart:math' as math;

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:rshb_test/colors.dart';
import 'package:rshb_test/detail/action.dart';
import 'package:rshb_test/detail/state.dart';
import 'package:rshb_test/product/models/cachedImage.dart';
import 'package:rshb_test/product/models/catalogModel.dart';
import 'package:rshb_test/strings.dart';
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
        item.characteristics.isNotEmpty ? CharacteristicsDesign(
          items: item.characteristics.map((e) => CharacteristicItem(item: e)).toList(),
          visibleSize: item.characteristics.length <= 3 ? item.characteristics.length : 3,
        ) : Container(),
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
                  blurRadius: 2,
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
  
  Widget _buildBackIcon() =>
    BackIcon(
      size: 40,
      onTap: () => dispatch(DetailActionCreator.backIconTapped()),
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
            ),
            Positioned(
              top: 60,
              left: 16,
              child: _buildBackIcon(),
            )
          ],
        )
      )
    );
  }

}

class CharacteristicsDesign extends StatefulWidget {

  final List<Widget> items;
  final int visibleSize;

  const CharacteristicsDesign({
    this.items,
    this.visibleSize,
  });

  @override
  CharacteristicsDesignState createState() => CharacteristicsDesignState();

}

class CharacteristicsDesignState extends State<CharacteristicsDesign> {

  bool _isExpanded;
  List<Widget> _visibleItems;
  double _angle;
  bool _isExpandedList;

  @override
  void initState() {
    _isExpanded = false;
    _angle = 0;
    _isExpandedList = widget.items.length <= 3 ? false : true;
    _visibleItems = !_isExpandedList ? widget.items : widget.items.sublist(0, widget.visibleSize);
    super.initState();
  }

  void _buttonTapped() =>
    _isExpanded ? setState(() {
      _isExpanded = !_isExpanded;
      _angle = 0;
      _visibleItems = widget.items.sublist(0, widget.visibleSize);
    }) : setState(() {
      _isExpanded = !_isExpanded;
      _angle = -math.pi / 2;
      _visibleItems = widget.items;
    });

  Widget _buildButtonTitle() =>
    Text(
      _isExpanded ? Strings.characteristicsExpanded : Strings.characteristicsHidden,
      style: TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: ColorsDesign.ratingLabelExcellent,
        letterSpacing: -0.2
      ),
    );

  Widget _buildButtonSymbol() =>
    IconDesign(
      icon: 'assets/icons/arrow.png',
      size: 24,
      angle: _angle,
    );

  Widget _buildButton() =>
    GestureDetector(
      onTap: _buttonTapped,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildButtonTitle(),
          _buildButtonSymbol()
        ],
      )
    );
    

  @override
  Widget build(BuildContext context) =>
    Column(
      children: List<Widget>()
      ..addAll(_visibleItems)
      ..add(_isExpandedList ? _buildButton() : Container())
    );

}

class CharacteristicItem extends StatelessWidget {

  final Characteristic item;

  const CharacteristicItem({
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