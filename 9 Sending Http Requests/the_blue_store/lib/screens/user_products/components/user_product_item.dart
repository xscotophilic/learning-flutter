import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../edit_product_screen.dart';
import '../../../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURL;
  final Color productColor;

  const UserProductItem({
    Key? key,
    required this.id,
    required this.title,
    required this.imageURL,
    required this.productColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      leading: CircleAvatar(
        backgroundColor: productColor,
        backgroundImage: NetworkImage(
          imageURL,
        ),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                  arguments: id,
                );
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                Provider.of<Products>(context, listen: false).deleteProduct(id);
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
