import 'package:flutter/material.dart';

import '../widgets/banner.dart';
import '../widgets/productsGrid.dart';

class ProductsOverviewScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return wrapWithBanner(
      Scaffold(
        appBar: AppBar(
          title: Text('Shopping App'),
          centerTitle: true,
        ),
        body: ProductsGrid(),
      ),
    );
  }
}
