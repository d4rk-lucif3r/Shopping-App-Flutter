import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/cart.dart';
import './providers/orders.dart';
import './providers/products_provider.dart';
import './screens/cart_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/userProducts_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProviders(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping App',
        theme: ThemeData(
          backgroundColor: Colors.black,
          canvasColor: Colors.black,
          primarySwatch: Colors.red,
          accentColor: Colors.amberAccent,
          fontFamily: 'Lato',
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return CupertinoPageRoute(
                  builder: (_) => ProductsOverviewScreen(), settings: settings);
            case ProductDetailScreen.routeName:
              return CupertinoPageRoute(
                  builder: (_) => ProductDetailScreen(), settings: settings);
            case CartScreen.routeName:
              return CupertinoPageRoute(
                  builder: (_) => CartScreen(), settings: settings);

            case OrdersScreen.routeName:
              return CupertinoPageRoute(
                  builder: (_) => OrdersScreen(), settings: settings);
            case UserProductScreen.routeName:
              return CupertinoPageRoute(
                  builder: (_) => UserProductScreen(), settings: settings);
            case EditProductScreen.routeName:
              return CupertinoPageRoute(
                  builder: (_) => EditProductScreen(), settings: settings);
            default:
              return CupertinoPageRoute(
                  builder: (_) => ProductsOverviewScreen(), settings: settings);
          }
        },
      ),
    );
  }
}
