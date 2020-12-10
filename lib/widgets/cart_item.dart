import 'package:flutter/material.dart';

class CartItems extends StatelessWidget {
  final String id;
  final double price;
  final String title;
  final int quantity;

  const CartItems({
    @required this.id,
    @required this.price,
    @required this.title,
    @required this.quantity,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 12,
      shadowColor: Colors.blueGrey,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(child: Text('\$$price')),
          ),
          title: Text(title),
          subtitle: Text('Total : \$ ${price * quantity}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
