import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../widgets/banner.dart';
import '../widgets/productsGrid.dart';
import './cart_screen.dart';
import '../providers/products_provider.dart';

enum FilterOptions {
  Favorites,
  All,
  Cart,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    //Provider.of<ProductsProviders>(context).fetchAndSetProduct();
    // Future.delayed(Duration.zero).then((_){
    //   Provider.of<ProductsProviders>(context).fetchAndSetProduct();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProviders>(context)
          .fetchAndSetProduct()
          .then((value) => _isLoading = false);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return wrapWithBanner(
      Scaffold(
        appBar: AppBar(
          title: Text('Shopping App'),
          centerTitle: true,
          actions: <Widget>[
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                child: ch,
                value: cart.itemCount.toString(),
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
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
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text(
                    'Only Favorites❤',
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
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ProductsGrid(showFavs: _showOnlyFavorites),
      ),
    );
  }
}
