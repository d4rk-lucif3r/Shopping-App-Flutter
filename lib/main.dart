import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './widgets/banner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      theme: ThemeData(
          backgroundColor: Colors.black,
          canvasColor: Colors.black,
          primarySwatch: Colors.red,
          accentColor: Colors.amberAccent,
          fontFamily: 'Lato'),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return CupertinoPageRoute(builder: (_) => ProductsOverviewScreen());
          case ProductDetailScreen.routeName:
            return CupertinoPageRoute(builder: (_) => ProductDetailScreen());
          default:
            return CupertinoPageRoute(builder: (_) => ProductsOverviewScreen());
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return wrapWithBanner(Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Text(
            '',
          ),
        )));
  }
}
