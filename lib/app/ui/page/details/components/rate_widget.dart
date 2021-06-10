import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shopping_phone/app/constants/controllers.dart';
import 'package:shopping_phone/app/model/product.dart';
import 'package:shopping_phone/app/model/rate.dart';
import 'package:shopping_phone/app/ui/theme/app_theme.dart';
import 'package:uuid/uuid.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingButton(
          tap: () {
            _showRatingAppDialog();
          },
          text: 'Rating',
        ),
      ],
    );
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

class RatingButton extends StatelessWidget {
  const RatingButton({
    Key key,
    @required this.tap,
    @required this.text,
  }) : super(key: key);

  final GestureTapCallback tap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        height: 30.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20 * 0.5), color: textColor),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
