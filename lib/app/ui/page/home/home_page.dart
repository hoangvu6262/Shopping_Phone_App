import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_phone/app/constants/controllers.dart';
import 'package:shopping_phone/app/controller/auth_controller.dart';
import 'package:shopping_phone/app/controller/product_controller.dart';
import 'package:shopping_phone/app/model/product.dart';
import 'package:shopping_phone/app/routes/app_pages.dart';
import 'package:shopping_phone/app/ui/page/home/home_desktop.dart';
import 'package:shopping_phone/app/ui/page/home/home_mobile.dart';
import 'package:shopping_phone/app/ui/page/home/home_tablet.dart';
import 'package:shopping_phone/app/ui/page/widgets/loading_widget.dart';
import 'package:shopping_phone/app/ui/responsive/responsive_page.dart';

import '../../shared/badge.dart';

class HomePage extends GetView<ProductController> with ResponsivePage {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Transform.translate(
            offset: Offset(20 * 0.5, 0),
            child: IconButton(
                icon: Image.asset('assets/images/user.png'), onPressed: () {})),
        actions: [
          GetBuilder<UserController>(
            init: UserController(),
            builder: (ctl) {
              return Badge(
                value: ctl.count.toString(),
                color: Colors.orange,
                child: IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: () {
                    Get.toNamed(Routes.CART);
                  },
                ),
              );
            },
          ),
          PopupMenuButton(
            onSelected: (String option) {
              switch (option) {
                case "giaGiam":
                  productController.products
                      .sort((a, b) => (b.price).compareTo((a.price)));
                  break;
                case "giaTang":
                  productController.products
                      .sort((a, b) => (a.price).compareTo((b.price)));
                  break;
              }
            },
            icon: Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  child: Text('Giá tăng dần'),
                  value: "giaTang",
                ),
                PopupMenuItem(
                  child: Text('Giá giảm dần'),
                  value: "giaGiam",
                ),
              ];
            },
          ),
        ],
      ),
      body: buildUi(context),
    );
  }

  @override
  Widget buildMobile(BuildContext context) {
    return Obx(
      () => productController.products.length < 0
          ? LoadingWidget()
          : HomeMobile(listData: productController.products),
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return HomeDesktop();
  }

  @override
  Widget buildTablet(BuildContext context) {
    return HomeTablet();
  }
}

class Search extends SearchDelegate {
  final List<Product> listProducts;

  Search(this.listProducts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> temp = [];

    for (int i = 0; i < listProducts.length; i++) {
      temp.add(listProducts[i].title);
    }
    List<Product> recentList = [];
    List<Product> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listProducts.where(
            // In the false case
            (element) => element.title.contains(query),
          ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index].title,
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: () {
            Get.toNamed(Routes.DETAILS, arguments: suggestionList[index]);
          },
        );
      },
    );
  }
}
