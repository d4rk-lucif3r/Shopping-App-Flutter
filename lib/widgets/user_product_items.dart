import 'package:flutter/material.dart';

class UserProductItems extends StatelessWidget {
  final String title;
  final String imageUrl;

  const UserProductItems({
    @required this.title,
    @required this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
