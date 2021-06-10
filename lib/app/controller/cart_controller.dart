import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_phone/app/constants/controllers.dart';
import 'package:shopping_phone/app/model/cart.dart';
import 'package:shopping_phone/app/model/product.dart';
import 'package:shopping_phone/app/model/user.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();
  RxDouble totalCartPrice = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    ever(userController.userModel, changeCartTotalPrice);
  }

  void addProductToCart(Product product) {
    try {
      if (_isItemAlreadyAdded(product)) {
        Get.snackbar(
            "Check your cart", "${product.title} đã tồn tại trong giỏ hàng");
      } else {
        String itemId = Uuid().v4().toString();
        userController.updateUserData({
          "cart": FieldValue.arrayUnion([
            {
              "id": itemId,
              "productId": product.id,
              "name": product.title,
              "quantity": 1,
              "price": product.price,
              "image": product.imageUrl,
              "cost": product.price
            }
          ])
        });
        Get.snackbar(
            "Item added", "${product.title} đã được thêm vào giỏ hàng");
      }
    } catch (e) {
      Get.snackbar("Error", "Cannot add this item");
      debugPrint(e.toString());
    }
  }

  void removeCartItem(CartModel cartItem) {
    try {
      userController.updateUserData({
        "cart": FieldValue.arrayRemove([cartItem.toJson()])
      });
    } catch (e) {
      Get.snackbar("Error", "Cannot remove this item");
      debugPrint(e.message);
    }
  }

  changeCartTotalPrice(UserModel userModel) {
    totalCartPrice.value = 0.0;
    if (userModel.cart.isNotEmpty) {
      userModel.cart.forEach((cartItem) {
        totalCartPrice += cartItem.cost;
      });
    }
  }

  bool _isItemAlreadyAdded(Product product) =>
      userController.userModel.value.cart
          .where((item) => item.productId == product.id)
          .isNotEmpty;

  //giảm số lượng
  void decreaseQuantity(CartModel item) {
    if (item.quantity == 1) {
      removeCartItem(item);
    } else {
      removeCartItem(item);
      item.quantity--;
      userController.updateUserData({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
    }
  }

  //tăng số lượng
  void increaseQuantity(CartModel item) {
    removeCartItem(item);
    item.quantity++;
    // logger.i({"quantity": item.quantity});
    userController.updateUserData({
      "cart": FieldValue.arrayUnion([item.toJson()])
    });
  }
}
