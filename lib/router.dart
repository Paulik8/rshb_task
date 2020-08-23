import 'package:fish_redux/fish_redux.dart';
import 'package:rshb_test/detail/page.dart';
import 'package:rshb_test/home/page.dart';

class CustomRouter {
  static AbstractRoutes generateRoute() {
    final AbstractRoutes routes = PageRoutes(
        pages: <String, Page<Object, dynamic>>{
          'home': HomePage(),
          'detail': DetailPage(),
        },
    );
    return routes;
  }
}


