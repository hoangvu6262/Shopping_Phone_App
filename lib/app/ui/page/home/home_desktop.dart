import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_phone/app/constants/controllers.dart';
import 'package:shopping_phone/app/model/product.dart';
import 'package:shopping_phone/app/ui/page/widgets/loading_widget.dart';

import 'widgets/product_item_widget.dart';

class HomeDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> products;

    return StreamBuilder(
        stream: productController.getProductRealTime(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            products = snapshot.data.docs
                .map((doc) => Product.fromMap(doc.data()))
                .toList();

            return GridView.count(
              crossAxisCount: 4,
              childAspectRatio: .63,
              padding: const EdgeInsets.all(10),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 10,
              children: products.map((product) {
                return ProductItem(
                  product: product,
                );
              }).toList(),
            );
          } else {
            return LoadingWidget();
          }
        });
  }
}
