import 'package:flutter/material.dart';
import '../screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class UserProductItems extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItems({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
    final scaffoldContext = ScaffoldMessenger.of(context);
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ListTile(
        tileColor: Colors.white,
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    EditProductScreen.routeName,
                    arguments: id,
                  );
                },
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  try {
                    await Provider.of<ProductsProviders>(context, listen: false)
                        .deleteProduct(id);
                  } catch (error) {
                    scaffoldContext.showSnackBar(SnackBar(
                      content: Text('Error Deleting'),
                      backgroundColor: theme.primaryColor,
                      elevation: 10,
                    ));
                  }
                },
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
