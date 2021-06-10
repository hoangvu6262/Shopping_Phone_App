import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_phone/app/model/cart.dart';

class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const CART = "cart";

  String id;
  String name;
  String email;
  List<CartModel> cart;

  UserModel({this.id, this.name, this.email, this.cart});

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot[NAME];
    email = snapshot[EMAIL];
    id = snapshot[ID];
    cart = _convertCartItems(snapshot[CART] ?? []);
  }

  List<CartModel> _convertCartItems(List cartFomDb) {
    List<CartModel> _result = [];
    if (cartFomDb.length > 0) {
      cartFomDb.forEach((element) {
        _result.add(CartModel.fromMap(element));
      });
    }
    return _result;
  }

  List cartItemsToJson() => cart.map((item) => item.toJson()).toList();

  @override
  String toString() {
    return "User: ${this.id} - ${this.name} -  ${this.email} - ${this.cart}";
  }
}
