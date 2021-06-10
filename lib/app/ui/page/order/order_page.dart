import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_phone/app/constants/controllers.dart';
import 'package:shopping_phone/app/controller/order_controller.dart';
import 'package:shopping_phone/app/model/order.dart';

import 'widget/order_item_widget.dart';

class OrderPage extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    List<OrderModel> products;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('my_orders'.tr),
      ),
      body: ListView(
        children: [
          StreamBuilder(
              stream: orderController.getOrderHistoryRealTime(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  products = snapshot.data.docs
                      .map((doc) => OrderModel.fromMap(doc.data()))
                      .toList();
                  return Column(
                    children: products.map((item) {
                      return OrderWidget(
                        orderModel: item,
                      );
                    }).toList(),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }
}
