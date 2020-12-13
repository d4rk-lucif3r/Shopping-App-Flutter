import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (ctx, dataSnapShot) {
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapShot.error != null) {
                return Center(
                  child: Text('An error Occured'),
                );
              } else {
                return RefreshIndicator(
                    onRefresh: () async {
                      return await Provider.of<Orders>(context, listen: false)
                          .fetchAndSetOrders();
                    },
                    child: Consumer<Orders>(
                      builder: (ctx, orderData, child) => (ListView.builder(
                        itemBuilder: (ctx, index) {
                          return OrderItems(
                            order: orderData.orders[index],
                          );
                        },
                        itemCount: orderData.orders.length,
                      )),
                    ));
              }
            }
          }),
    );
  }
}
