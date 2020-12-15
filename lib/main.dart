import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/products_provider.dart';
import './screens/auth_screen.dart';
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
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductsProviders>(
            create: (ctx) => ProductsProviders(),
            update: (ctx, authData, previousProductProvider) =>
                previousProductProvider
                  ..credentialSetterProducts(authData.userId, authData.token)),
        //   previousProductProvider..authToken = authData.token;
        //   previousProductProvider..userId = authData.userId;
        // }),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(),
          update: (ctx, authData, previousOrders) => previousOrders
            ..credentialSetterOrders(authData.userId, authData.token),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shopping App',
          theme: ThemeData(
            backgroundColor: Colors.black,
            canvasColor: Colors.black,
            primarySwatch: Colors.red,
            accentColor: Colors.amberAccent,
            fontFamily: 'Lato',
          ),
          home: authData.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          onGenerateRoute: (settings) {
            switch (settings.name) {
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
                    builder: (_) => AuthScreen(), settings: settings);
            }
          },
        ),
      ),
    );
  }
}
