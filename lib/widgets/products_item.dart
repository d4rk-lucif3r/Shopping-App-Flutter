import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    final scaffoldContext = ScaffoldMessenger.of(context);
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            softWrap: true,
          ),
          backgroundColor: Colors.blueGrey.withOpacity(.87),
          leading: Consumer<Product>(
              builder: (ctx, product, child) => IconButton(
                    icon: Icon(
                      product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.pink,
                    ),
                    onPressed: () async {
                      try {
                        await product.togglefavoriteStatus(
                            product.id, authData.token);
                      } on Exception catch (_) {
                        scaffoldContext.showSnackBar(SnackBar(
                          content: Text(
                            'Error Changing Favorite',
                            textAlign: TextAlign.center,
                          ),
                          duration: Duration(seconds: 2),
                          backgroundColor: theme.primaryColor,
                          elevation: 10,
                        ));
                      }
                    },
                  )),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              cart.addItems(
                product.id,
                product.price,
                product.title,
              );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Added Item to Cart',
                ),
                backgroundColor: Theme.of(context).primaryColor,
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    cart.removeSingleItem(product.id);
                  },
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}
