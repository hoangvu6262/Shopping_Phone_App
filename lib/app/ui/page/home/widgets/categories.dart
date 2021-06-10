import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopping_phone/app/constants/controllers.dart';
import 'package:shopping_phone/app/controller/category_controller.dart';
import 'package:shopping_phone/app/model/category.dart';
import 'package:shopping_phone/app/ui/theme/app_theme.dart';
import './Category.dart';

class Categories extends GetView<CategoryController> {
  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categories;
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: SizedBox(
        height: 35,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            StreamBuilder(
                stream: categoryController.getCategoryRealTime(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    categories = snapshot.data.docs
                        .map((doc) => CategoryModel.fromMap(doc.data()))
                        .toList();
                    return Row(
                      children: categories.map((item) {
                        return InkWell(
                          onTap: () {
                            productController
                                .getProductByCategorie(item.name.toString());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: bgColor,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20 * 0.8),
                            margin: EdgeInsets.only(right: 20 * 0.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/star.svg",
                                  color: Color(0xFF4F4F4F),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  item.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF4F4F4F),
                                    // fontWeight: selectedIndex == index
                                    //     ? FontWeight.bold
                                    //     : FontWeight.w300
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })
          ],
        ),
      ),
    );
  }
}
