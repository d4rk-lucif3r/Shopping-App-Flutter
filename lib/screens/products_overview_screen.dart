import 'package:flutter/material.dart';

import '../widgets/banner.dart';
import '../widgets/productsGrid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return wrapWithBanner(
      Scaffold(
        appBar: AppBar(
          title: Text('Shopping App'),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton(
              padding: EdgeInsets.all(20),
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 7,
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showOnlyyFavorites = true;
                  } else {
                    _showOnlyyFavorites = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text(
                    'Only Favorites',
                    textAlign: TextAlign.center,
                  ),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text(
                    'Show All',
                    textAlign: TextAlign.center,
                  ),
                  value: FilterOptions.All,
                ),
              ],
            )
          ],
        ),
        body: ProductsGrid(showFavs:_showOnlyyFavorites),
      ),
    );
  }
}
