import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopping_phone/app/constants/controllers.dart';
import 'package:shopping_phone/app/constants/firebase.dart';
import 'package:shopping_phone/app/model/order.dart';
import 'package:uuid/uuid.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();
  String collection = "orders";

  RxList<OrderModel> payments = RxList<OrderModel>();

  @override
  void onReady() {
    super.onReady();
    getOrderHistory();
  }

  // lấy danh sách order
  getOrderHistory() {
    payments.clear();
    firebaseFirestore
        .collection(collection)
        .where("userId", isEqualTo: userController.userModel.value.id)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        OrderModel payment = OrderModel.fromMap(doc.data());
        payments.add(payment);
        update();
      });
      print("crthang order ${payments.length}");
    });
  }

  // lấy danh sách order
  Stream<QuerySnapshot> getOrderHistoryRealTime() {
    payments.clear();
    return firebaseFirestore
        .collection(collection)
        .where("userId", isEqualTo: userController.userModel.value.id)
        .snapshots();
  }

  //thêm vào Collection
  void addToCollection(String phoneNumber) {
    DateTime _now = new DateTime.now();
    String id = Uuid().v1();
    firebaseFirestore.collection(collection).doc(id).set({
      "id": id,
      "phone": phoneNumber,
      "userId": userController.userModel.value.id,
      "amount": cartController.totalCartPrice.value.toStringAsFixed(2),
      "nameUser": userController.userModel.value.name,
      "status": 'Pending',
      "createdAt":
          '${_now.year}/${_now.month}/${_now.day}- ${_now.hour}:${_now.minute}',
      "cart": userController.userModel.value.cartItemsToJson(),
    });

    firebaseFirestore
        .collection("users")
        .doc('${userController.userModel.value.id}')
        .update({
      "cart": FieldValue.arrayRemove(
          userController.userModel.value.cartItemsToJson())
    });
    Get.snackbar("Success", "Đặt hàng thành công!");
  }
}
