import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_phone/app/constants/controllers.dart';
import 'package:shopping_phone/app/model/product.dart';
import 'package:shopping_phone/app/routes/app_pages.dart';

import '../../widgets/custom_text.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key key, this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    var result;
    if (product.rate != null) {
      result = product.rate.map((m) => m['rate']).reduce((a, b) => a + b) /
          product.rate.length;
    } else {
      result = 0;
    }

    print("crthang rate $result");

    return InkWell(
      onTap: () => {Get.toNamed(Routes.DETAILS, arguments: product)},
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.5),
                  offset: Offset(3, 2),
                  blurRadius: 7)
            ]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    product.imageUrl,
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: CustomText(
                text: product.title ?? "Title",
                size: 14,
                weight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: result != 0
                      ? "${result.toStringAsFixed(1)}"
                      : "No review",
                  color: Colors.grey,
                ),
                Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 15.0,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: CustomText(
                    text: "\$${product.price}",
                    size: 14,
                    weight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    icon: Icon(
                      Icons.shopping_basket,
                      size: 20,
                    ),
                    onPressed: () {
                      cartController.addProductToCart(product);
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
