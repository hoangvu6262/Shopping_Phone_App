import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_phone/app/constants/controllers.dart';
import 'package:shopping_phone/app/model/product.dart';
import 'package:shopping_phone/app/model/rate.dart';
import 'package:shopping_phone/app/ui/page/widgets/custom_text.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:uuid/uuid.dart';

import 'comment_widget.dart';

class ProductDetailsWidget extends StatelessWidget {
  final Product product;

  ProductDetailsWidget({this.product});

  @override
  Widget build(BuildContext context) {
    var result;
    if (product.rate != null) {
      result = product.rate.map((m) => m['rate']).reduce((a, b) => a + b) /
          product.rate.length;
    } else {
      result = 0;
    }

    return ListView(children: [
      SizedBox(height: 15.0),
      Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Text(product.title,
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF17532))),
      ),
      SizedBox(height: 15.0),
      // -------------------------------- Product Image------------------------------- //
      Image.network(product.imageUrl,
          height: 150.0, width: 100.0, fit: BoxFit.contain),
      SizedBox(height: 20.0),
      // -------------------------------- Product Price------------------------------- //
      Center(
        child: Text("\$${product.price.toString()}",
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF17532))),
      ),
      SizedBox(height: 10.0),
      // -------------------------------- Product Name ------------------------------- //
      Center(
        child: Text(product.title ?? "Title",
            style: TextStyle(color: Color(0xFF575E67), fontSize: 24.0)),
      ),
      SizedBox(height: 20.0),
      // -------------------------------- Product Rate ------------------------------- //
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: result != 0
                  ? "${result.toStringAsFixed(1)}"
                  : "chưa có đánh giá",
              color: Colors.grey,
              size: 22,
            ),
            Icon(
              Icons.star,
              color: Colors.orange,
              size: 25.0,
            ),
          ],
        ),
      ),
      SizedBox(height: 20.0),
      Center(
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: Colors.cyan,
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Text(
            'Rating',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: _showRatingAppDialog,
        ),
      ),
      // -------------------------------- Product Description ------------------------------- //
      SizedBox(height: 20.0),
      Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 50.0,
          child: Text(product.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, color: Color(0xFFB4B8B9))),
        ),
      ),
      SizedBox(height: 20.0),
      // -------------------------------- Btn Add To Cart------------------------------- //
      Center(
        child: InkWell(
          onTap: () => {cartController.addProductToCart(product)},
          child: Container(
              width: MediaQuery.of(context).size.width - 100.0,
              height: 50.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color(0xFFF17532)),
              child: Center(
                  child: Text(
                'Add to cart',
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ))),
        ),
      ),

      Center(
        child: Container(
          margin: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            children: [
              CommentWidget(id: "${product.id}"),
            ],
          ),
        ),
      )
    ]);
  }

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: 'Rating ${product.title}',
      message: 'Rating this product.'
          ' Add more description here if you want.',
      image: Image.network(product.imageUrl,
          height: 100.0, width: 100.0, fit: BoxFit.contain),
      submitButton: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, '
            'comment: ${response.comment}');
        String itemId = Uuid().v4().toString();

        productController.addRateToProduct(
            RateModel(
                id: itemId,
                rate: response.rating.toDouble(),
                comment: response.comment),
            product.id);
      },
    );

    showDialog(
      context: Get.context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }
}
