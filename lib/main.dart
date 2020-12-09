import 'package:flutter/material.dart';

import './widgets/banner.dart';
import './screens/products_overview_screen.dart';

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
        fontFamily: 'Lato'
      ),
      home: ProductsOverviewScreen(),
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
