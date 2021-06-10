import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopping_phone/app/constants/controllers.dart';
import 'package:shopping_phone/app/ui/page/home/widgets/categories.dart';
import 'package:shopping_phone/app/ui/page/home/widgets/filter.dart';
import 'package:shopping_phone/app/ui/theme/app_theme.dart';

import 'widgets/product_item_widget.dart';
import 'widgets/search_bar.dart';

class HomeMobile extends StatelessWidget {
  List listData = [];

  HomeMobile({Key key, @required this.listData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Favorite brands\nAnd hottest trends for You',
            style: TextStyle(
                color: textColor, fontSize: 24, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 20),
          SearchBar(),
          Row(children: [
            FilterButton(
              tap: () {
                productController.getProducts();
              },
            ),
            Expanded(child: Categories())
          ]),
          SizedBox(height: 20),
          Text(
            'Popular',
            style: TextStyle(
                color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Container(
            child: StaggeredGridView.countBuilder(
              padding: EdgeInsets.all(0),
              crossAxisCount: 2,
              itemCount: listData.length,
              crossAxisSpacing: 5,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              mainAxisSpacing: 5,
              itemBuilder: (context, index) {
                return ProductItem(product: listData[index]);
              },
              staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            ),
          ),
        ],
      ),
    );
  }
}
