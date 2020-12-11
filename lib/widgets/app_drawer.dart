import 'package:flutter/material.dart';
import '../screens/orders_screen.dart';
import '../screens/userProducts_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ClipRRect(
          
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: ListTile(
              
              tileColor: Colors.white,
              leading: Icon(Icons.shop),
              title: Text('Shop'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ),
          ListTile(
            tileColor: Colors.white,
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.routeName);
            },
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            child: ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.payments),
              title: Text('Order'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
