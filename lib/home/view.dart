import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:rshb_test/home/state.dart';
import 'package:rshb_test/product/models/catalogModel.dart';
import 'package:rshb_test/widgets/tabBarDesign.dart';

Widget buildView(HomeState state, Dispatch dispatch, ViewService viewService) {

  final catalog = state.catalog;
  List<Item> sections;
  if (catalog == null) {
    return Container(color: Colors.white, child: Center(child: CircularProgressIndicator()));
  } else {
    if (catalog.sections == null || catalog.sections.isEmpty) {
      sections = List();
      return Center(
        child: Container(
          child: Text('Нет контента'),
        )
      );
    } else {
      sections = catalog.sections;
    }
  }

  final sectionsStr = sections.map((e) => e.title).toList();

  Widget _buildItem(Widget child) =>
    Center(
      child: child,
    );

  List<Widget> _buildComponents() {
    var widgets = List<Widget>();
    sectionsStr.asMap().forEach((index, el) => el == 'Продукты' ? widgets.add(_buildItem(Visibility(
        child: Column(
          children: [
            viewService.buildComponent('filter'),
            viewService.buildComponent('product'),
          ]
        ),
        maintainState: true,
        visible: state.currentIndex == index,
      ))) : widgets.add(_buildItem(Visibility(
        child: Text('$el'),
        maintainState: true,
        visible: state.currentIndex == index,
      ))));
    return widgets;
  }

  Widget _buildContent() =>
      ListView(
        shrinkWrap: true,
        children: [
         TabBarDesign(
           tabController: state.tabController,
           titles: sectionsStr,
           dispatch: dispatch,
          ),
         IndexedStack(
          children: _buildComponents(),
          index: state.currentIndex,
         )
        ]
    );
  
  Widget _buildScreen() =>  
    DefaultTabController(
      length: 3,
      child: 
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Каталог', 
            style: TextStyle(
              color: Colors.black
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 6,
          brightness: Brightness.light,
        ),
        body: _buildContent(),
        )
      );
  
  return _buildScreen();

}