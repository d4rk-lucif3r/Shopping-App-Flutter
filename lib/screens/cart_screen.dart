import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 12,
            shadowColor: Colors.blueGrey,
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text('\$${cartData.totalItems.toStringAsFixed(2)}'),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                        cartData.items.values.toList(),
                        cartData.totalItems,
                      );
                      cartData.clearCart();
                    },
                    child: Text('ORDER NOW'),
                    textColor: Theme.of(context).accentColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) => CartItems(
                id: cartData.items.values.toList()[index].id,
                productId: cartData.items.keys.toList()[index],
                title: cartData.items.values.toList()[index].title,
                price: cartData.items.values.toList()[index].price,
                quantity: cartData.items.values.toList()[index].quantity,
              ),
              itemCount: cartData.itemCount,
            ),
          )
        ],
      ),
    );
  }
}
