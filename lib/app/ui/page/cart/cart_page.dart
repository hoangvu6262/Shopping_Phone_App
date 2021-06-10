import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopping_phone/app/constants/controllers.dart';
import 'package:shopping_phone/app/ui/page/cart/widgets/cart_item_widget.dart';
import 'package:shopping_phone/app/ui/page/widgets/app_bar.dart';
import 'package:shopping_phone/app/ui/page/widgets/custom_btn.dart';
import 'package:shopping_phone/app/ui/page/widgets/custom_text.dart';
import 'package:shopping_phone/app/ui/theme/app_theme.dart';

class CartPage extends StatelessWidget {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context,
            leading: IconButton(
                icon: SvgPicture.asset('assets/icons/back.svg'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: "your_cart".tr,
            actions: <Widget>[]),
        body: Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: CustomText(
                    text: "your_cart".tr,
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Obx(() => userController.userModel.value.cart.length > 0
                    ? Column(
                        children: userController.userModel.value.cart
                            .map((cartItem) => CartItemWidget(
                                  cartItem: cartItem,
                                ))
                            .toList(),
                      )
                    : Container(
                        child: Center(
                            child:
                                CustomText(text: "cart_is_empty".tr, size: 20)),
                      )),
              ],
            ),
            Positioned(
                bottom: 30,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(8),
                    child: Obx(
                      () => CustomButton(
                          bgColor: textColor,
                          text: "pay".tr +
                              " (\$${cartController.totalCartPrice.value.toStringAsFixed(2)})",
                          onTap: () {
                            Get.defaultDialog(
                                title: "Enter your phone",
                                textConfirm: "Confirm",
                                textCancel: "Cancel",
                                content: Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        "Enter your phone number for us to confirm your order",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    TextField(
                                      keyboardType: TextInputType.number,
                                      controller: phoneController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Phone number...',
                                      ),
                                    )
                                  ],
                                ),
                                onConfirm: () {
                                  if (phoneController.text != "") {
                                    Get.back();
                                    orderController.addToCollection(
                                        phoneController.text.trim());
                                    phoneController.clear();
                                  } else {
                                    Get.snackbar(
                                        "Error", "Phone number is required");
                                  }
                                });
                          }),
                    )))
          ],
        ));
  }
}
