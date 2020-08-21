import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:rshb_test/colors.dart';
import 'package:rshb_test/home/action.dart';

class TabBarDesign extends StatelessWidget {
  
  final TabController tabController;
  final List<String> titles;
  final Dispatch dispatch;

  const TabBarDesign({
    this.titles,
    this.tabController,
    this.dispatch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: ColorsDesign.tabsBackground,
        ),
        child: Padding(
          padding: EdgeInsets.all(6),
          child: TabBar(
          controller: tabController,
          unselectedLabelColor: Colors.black,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            shape: BoxShape.rectangle,
            color: Colors.green,
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 3,
                offset: Offset(3, 1),
              ),
            ],
          ),
          tabs: titles.map((el) => TabBarCell(title: el,)).toList(),
          onTap: (value) => dispatch(HomeActionCreator.changeTab(value)),
        )
      ))
    );
  }

}

class TabBarCell extends StatelessWidget {

  final String title;

  const TabBarCell({
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
        child: Center(
          child: Text(title),
        ),
    );
  }

}