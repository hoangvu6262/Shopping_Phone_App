import 'package:flutter/material.dart';
import 'package:shopping_phone/app/constants/controllers.dart';
import 'package:shopping_phone/app/model/product.dart';
import 'package:shopping_phone/app/ui/theme/app_theme.dart';
import 'buy_button.dart';

class PriceAndBuy extends StatelessWidget {
  const PriceAndBuy({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Product item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  'Price',
                  style: TextStyle(fontSize: 18.0, color: textColor),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: '\$ ',
                        style: TextStyle(color: Colors.red, fontSize: 22)),
                    TextSpan(
                        text: item.price.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 18))
                  ]),
                )
              ],
            )),
        Spacer(),
        Expanded(
            flex: 4,
            child: BuyButton(tap: () {
              cartController.addProductToCart(item);
            })),
      ],
    );
  }
}
