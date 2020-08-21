import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:rshb_test/colors.dart';
import 'package:rshb_test/detail/view.dart';
import 'package:rshb_test/home/action.dart';
import 'package:rshb_test/product/models/cachedImage.dart';
import 'package:rshb_test/product/models/catalogModel.dart';
import 'package:rshb_test/widgets/converters.dart';
import 'package:rshb_test/widgets/iconDesign.dart';
import 'package:rshb_test/widgets/ratingLabel.dart';

class ProductCard extends StatelessWidget {

  final Product item;
  final CachedImage image;
  final String farmer;
  final Dispatch dispatch;

  const ProductCard({
    this.item,
    this.image,
    this.farmer,
    this.dispatch,
  });

  @override
  Widget build(BuildContext context) {
    
    Widget _buildFavourites() => 
      FavouritesIcon(
        size: 32,
        isActive: item.isFavourite,
        onTap: (isActive) => dispatch(HomeActionCreator.favouriteButtonTapped(<String, dynamic>{
          'product': item,
          'isActive': isActive
        })),
      );

    Widget _buildRating() => 
      CompositeRating(
        item: item,
      );

    Widget _buildText() =>
      Container(
        child: Text(
          item.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 10,
            fontWeight: FontWeight.normal,
            color: ColorsDesign.commonText,
          ),
        ),
      );

    Widget _buildPrice() =>
      PriceDesign(
        item: item,
      );
      

    Widget _buildFarmer() =>
      Container(
        child: Text(
          farmer,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 10,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      );

    Widget _buildTitle() =>
      CompositeTitle(
        item: item,
      );

    Widget _buildImage() => 
      Container(
        height: 123,
        child: VariableImage(
          url: item.image,
          image: image,
          analogPadding: EdgeInsets.only(top: 12),
          dispatch: dispatch,
        ),
      );

    Widget _buildContent() =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: 
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 13,),
          _buildTitle(),
          SizedBox(height: 22,),
          _buildRating(),
          SizedBox(height: 8,),
          _buildText(),
          SizedBox(height: 8,),
          _buildFarmer(),
          SizedBox(height: 21,),
          _buildPrice(),
        ],
      )
      );

    return GestureDetector(
      onTap: () => dispatch(HomeActionCreator.productCardTapped(item)),
      child: Container(
      margin: EdgeInsets.symmetric(vertical: 3.5, horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: ColorsDesign.cardCorner
        )
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildImage(),
              _buildContent(),
            ]
          ),
          Positioned(
            top: 12,
            right: 12,
            child: _buildFavourites(),
          ),
        ],
      )
      
    )
    );

  }

}

class PriceDesign extends StatelessWidget {

  final Product item;
  final double fontSize;
  final FontWeight fontWeight;

  const PriceDesign({
    this.item,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600
  });

  @override
  Widget build(BuildContext context) {
    final priceString = convertToUnit(item.price);
      return Container(
        alignment: Alignment.centerLeft,
        child: Text(
          '$priceString ₽',
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        )
      );
  }

}

class CompositeRating extends StatelessWidget {

  final Product item;
  final double fontSize;

  const CompositeRating({
    this.item,
    this.fontSize = 10
  });

  Widget _buildRatingCount() =>
      Text(
        '${item.ratingCount.toString()} оценка',
        style: TextStyle(
          fontFamily: 'SF Pro Display',
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
          color: ColorsDesign.commonText,
        ),
      );

    Widget _buildRating() => 
      Container(child: Row(
        children: [
          RatingLabel(rating: item.totalRating,),
          SizedBox(width: 5,),
          _buildRatingCount(),
        ],
      )
      );

  @override
  Widget build(BuildContext context) => 
    _buildRating();

}

class CompositeTitle extends StatelessWidget {

  final Product item;
  final double fontSize;
  final double secondaryFontSize;
  final FontWeight fontWeight;

  const CompositeTitle({
    this.item,
    this.fontSize = 12,
    this.secondaryFontSize = 10,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) =>
    Container(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            item.title,
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontWeight: fontWeight,
              fontSize: fontSize,
              color: ColorsDesign.blackText,
            ),
          ),
          Text(
            ' / ${item.unit}',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w500,
              fontSize: secondaryFontSize,
              color: ColorsDesign.cardCorner
            ),
          )
        ])
      );

}