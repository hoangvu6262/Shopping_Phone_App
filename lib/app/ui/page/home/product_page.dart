import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopping_phone/app/controller/product_controller.dart';
import 'package:shopping_phone/app/model/product.dart';
import 'package:shopping_phone/app/ui/page/widgets/app_bar.dart';
import 'package:shopping_phone/app/ui/page/widgets/custom_text.dart';

import 'widgets/product_item_widget.dart';

class ProductPage extends GetView<ProductController> {
  List<Product> products = [];
  String category;

  ProductPage({@required this.products, @required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context,
            leading: IconButton(
                icon: SvgPicture.asset('assets/icons/back.svg'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: '$category',
            actions: <Widget>[]),
        body: products.length > 0
            ? Container(
                padding: EdgeInsets.all(10),
                child: StaggeredGridView.countBuilder(
                  padding: EdgeInsets.all(0),
                  crossAxisCount: 2,
                  itemCount: products.length,
                  crossAxisSpacing: 5,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  mainAxisSpacing: 5,
                  itemBuilder: (context, index) {
                    return ProductItem(product: products[index]);
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                ),
              )
            : Center(child: CustomText(text: "No data", size: 20)));
  }
}
