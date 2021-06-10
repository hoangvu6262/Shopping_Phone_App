import 'package:flutter/material.dart';
import 'package:shopping_phone/app/model/order.dart';
import 'package:shopping_phone/app/ui/page/widgets/custom_text.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel orderModel;

  const OrderWidget({Key key, this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 15)
          ]),
      child: Wrap(
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomText(
                  text: "ITEMS:",
                  color: Colors.grey,
                ),
              ),
              CustomText(
                text: orderModel.cart.length.toString(),
                color: Colors.black,
                weight: FontWeight.bold,
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: "\$ ${orderModel.amount}",
                  color: Colors.black,
                  weight: FontWeight.bold,
                  size: 18,
                ),
              ),
              SizedBox(
                width: 5,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomText(
              text: "PHONE: ${orderModel.phone.toString()}",
              color: Colors.deepOrange,
            ),
          ),
          Divider(),
          Column(
              children: orderModel.cart
                  .map((item) => ListTile(
                        title: CustomText(
                          text: item['name'],
                        ),
                        trailing: CustomText(
                          text: "\$ ${item['cost']}",
                        ),
                      ))
                  .toList()),
          Divider(),
          ListTile(
            title: CustomText(
              text: "${orderModel.createdAt}",
              color: Colors.grey,
            ),
            trailing: CustomText(
              text: orderModel.status,
              color:
                  orderModel.status == 'Pending' ? Colors.yellow : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
