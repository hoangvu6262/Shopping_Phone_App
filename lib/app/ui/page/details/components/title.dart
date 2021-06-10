import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_phone/app/model/product.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Product item;

  @override
  Widget build(BuildContext context) {
    var result;
    if (item.rate != null) {
      result = item.rate.map((m) => m['rate']).reduce((a, b) => a + b) /
          item.rate.length;
    } else {
      result = 0;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: item.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 10 * 0.5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/star.svg',
                    width: 20 * 0.8,
                  ),
                  SizedBox(
                    width: 20 * 0.5,
                  ),
                  Text(
                    result != 0
                        ? "${result.toStringAsFixed(1)} (${item.rate.length})"
                        : "chưa có đánh giá",
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
