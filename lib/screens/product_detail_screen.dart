import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/banner.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // const ProductDetailScreen({this.title, this.price});
  static const routeName = '/product-detail';
  // final String arguments;
  // ProductDetailScreen(this.arguments);
  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context).settings.arguments as String;
    final loadedProducts = Provider.of<ProductsProviders>(context)
        .items
        .firstWhere((prod) => prod.id == productID);

    return wrapWithBanner(Scaffold(
      appBar: AppBar(
        title: Text(loadedProducts.title),
        centerTitle: true,
      ),
    ));
  }
}
