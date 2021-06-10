import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_phone/app/constants/controllers.dart';
import 'package:shopping_phone/app/controller/category_controller.dart';
import 'package:shopping_phone/app/model/category.dart';
import 'package:shopping_phone/app/ui/page/category/widget/category_item_widget.dart';

class CategoryPage extends GetView<CategoryController> {
  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categories;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Categories'.tr),
      ),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.only(top: 10, bottom: 10)),
          Expanded(
            child: ListView(
              children: [
                StreamBuilder(
                    stream: categoryController.getCategoryRealTime(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        categories = snapshot.data.docs
                            .map((doc) => CategoryModel.fromMap(doc.data()))
                            .toList();
                        return Column(
                          children: categories.map((item) {
                            return CategoryItemWidget(
                                category: item,
                                onClickAction: () {
                                  categoryController.getProductByCategorie(
                                      item.name.toString());
                                });
                          }).toList(),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
