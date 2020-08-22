import 'package:flutter/material.dart';
import 'package:rshb_test/colors.dart';

class BackIcon extends StatelessWidget {

  final double size;
  final Function onTap;

  const BackIcon({
    this.size,
    this.onTap,
  });

  Widget _buildTapWrapper(Widget child) =>
    GestureDetector(
      onTap: onTap,
      child: child,
    );

  @override
  Widget build(BuildContext context) =>
    _buildTapWrapper(IconWrapper(
      icon: 'assets/icons/back.png',
      size: size,
    ));

}

class FavouritesIcon extends StatelessWidget {

  final double size;
  final Function(bool) onTap;
  final bool isActive;

  const FavouritesIcon({
    this.size,
    this.onTap,
    this.isActive = false,
  });

  Widget _buildTapWrapper(Widget child) =>
    GestureDetector(
      onTap: () {
        onTap(!isActive);
      },
      child: child,
    );

  @override
  Widget build(BuildContext context) =>
    isActive ?
      _buildTapWrapper(IconWrapper(
        icon: 'assets/icons/favourite_filled.png',
        size: size,
      )) :
      _buildTapWrapper(IconWrapper(
        icon: 'assets/icons/favourite.png',
        size: size,
      ));

}

class IconWrapper extends StatefulWidget {

  final String icon;
  final double size;

  const IconWrapper({
    this.icon,
    this.size,
  });

  @override
  IconWrapperState createState() => IconWrapperState();

}

class IconWrapperState extends State<IconWrapper> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: widget.size,
          width: widget.size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: ColorsDesign.filterBorder
            ),
            color: Colors.white
          ),
        ),
        IconDesign(
          icon: widget.icon,
          size: widget.size / 2,
        ),
      ],
    ); 
  }

}

class IconDesign extends StatefulWidget {

  final String icon;
  final double size;
  final double angle;

  const IconDesign({
    this.icon,
    this.size,
    this.angle = 0,
  });

  @override
  IconDesignState createState() => IconDesignState();

}

class IconDesignState extends State<IconDesign> {

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: widget.angle,
      child: Container(
        height: widget.size,
        width: widget.size,
        child: Image.asset(widget.icon, fit: BoxFit.fitWidth,)
      )
    );
    
  }

}