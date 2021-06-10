import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_phone/app/model/product.dart';

import './widgets/product_details_widget.dart';

class DetailsPage extends GetView {
  final Product product;

  DetailsPage({
    @required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[600]),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(product.title,
            style: TextStyle(fontSize: 18.0, color: Color(0xFF545D68))),
      ),
      body: ProductDetailsWidget(product: product),
    );
  }
}
