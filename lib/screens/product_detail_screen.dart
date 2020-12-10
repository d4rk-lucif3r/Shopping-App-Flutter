import 'package:flutter/material.dart';
import '../widgets/banner.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // const ProductDetailScreen({this.title, this.price});
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context).settings.arguments as String;
    //...
    return wrapWithBanner(Scaffold(
      appBar: AppBar(
        title: Text('title'),
        centerTitle: true,
      ),
    ));
  }
}
