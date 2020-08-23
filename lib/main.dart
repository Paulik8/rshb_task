import 'package:flutter/material.dart';
import 'package:rshb_test/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: 'home',
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) => 
        CustomRouter.generateRoute().buildPage(settings.name, settings.arguments),
      ),
    );
  }
}
