import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';

import '../providers/products_provider.dart';
import '../widgets/user_product_items.dart';
import './edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-productScreen';

  @override
  Widget build(BuildContext context) {
    Future<void> _refreshStatus() async {
      return await Provider.of<ProductsProviders>(context, listen: false)
          .fetchAndSetProduct(true);
    }

    return Scaffold(
        appBar: AppBar(title: const Text('Your Products'), actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ]),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: _refreshStatus(),
          builder: (ctx, dataSnapShot) =>
              dataSnapShot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: _refreshStatus,
                      child: Consumer<ProductsProviders>(
                        builder: (ctx, productData, _) => Padding(
                          padding: EdgeInsets.all(10),
                          child: ListView.builder(
                            itemBuilder: (_, i) {
                              return Column(children: [
                                UserProductItems(
                                  id: productData.items[i].id,
                                  imageUrl: productData.items[i].imageUrl,
                                  title: productData.items[i].title,
                                ),
                                Divider(),
                              ]);
                            },
                            itemCount: productData.items.length,
                          ),
                        ),
                      ),
                    ),
        ));
  }
}
