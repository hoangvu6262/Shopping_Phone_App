import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping_phone/app/model/product.dart';
import 'package:shopping_phone/app/ui/page/details/widgets/comment_widget.dart';
import 'package:shopping_phone/app/ui/page/widgets/app_bar.dart';
import 'package:shopping_phone/app/ui/theme/app_theme.dart';

import 'components/price_and_buy.dart';
import 'components/rate_widget.dart';
import 'components/title.dart';
import 'components/detail_category.dart';

class DetailsScreen extends StatelessWidget {
  final Product item;

  const DetailsScreen({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(context,
          leading: IconButton(
              icon: SvgPicture.asset('assets/icons/back.svg'),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: 'Detail',
          actions: <Widget>[]),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.only(top: size.height * 0.2),
            padding: EdgeInsets.only(top: size.height * 0.2),
            height: size.height * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0 * 5),
                  topRight: Radius.circular(20.0 * 5),
                ),
                color: bgColor),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    TitleBar(item: item),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Detail',
                          style: TextStyle(fontSize: 18, color: textColor),
                        ),
                        RatingWidget(
                          product: item,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      item.description,
                      style: TextStyle(fontSize: 14, color: textColor),
                    ),
                    SizedBox(height: 20),
                    DetailCategory(item: item),
                    SizedBox(height: 20.0 * 2),
                    PriceAndBuy(item: item),
                    SizedBox(height: 20),
                    Text(
                      'Comment:',
                      style: TextStyle(fontSize: 18, color: textColor),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Column(
                          children: [
                            CommentWidget(id: "${item.id}"),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Hero(
              tag: item.id,
              child: Container(
                margin: EdgeInsets.only(top: 2),
                child: Image.network(
                  item.imageUrl,
                  height: size.height * 0.4,
                  fit: BoxFit.fitHeight,
                ),
              )),
        ],
      ),
    );
  }
}
