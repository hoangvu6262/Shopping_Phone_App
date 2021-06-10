import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopping_phone/app/constants/controllers.dart';
import 'package:shopping_phone/app/constants/firebase.dart';
import 'package:shopping_phone/app/model/product.dart';
import 'package:shopping_phone/app/model/rate.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  String collection = "products";

  RxList<Product> products = RxList<Product>();

  var tmpProduct = Rx<Product>();

  @override
  void onReady() {
    super.onReady();
    getProducts();
  }

  // Get products from Firebase
  void getProducts() {
    products.clear();
    firebaseFirestore.collection(collection).get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        Product product = Product.fromMap(doc.data());
        products.add(product);
      });
    });
  }

  //Get product by ID  - Realtime
  Stream<QuerySnapshot> getProductByID(String productID) {
    return firebaseFirestore
        .collection(collection)
        .where("id", isEqualTo: productID.trim())
        .snapshots();
  }

  // Get products from Firebase - Realtime
  Stream<QuerySnapshot> getProductRealTime() {
    return firebaseFirestore.collection(collection).snapshots();
  }

  // Get products by category
  getProductByCategorie(String category) {
    products.clear();
    firebaseFirestore
        .collection("products")
        .where("category", isEqualTo: category.trim())
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        Product product = Product.fromMap(doc.data());
        products.add(product);
      });
      update();
    });
  }

  // Order by product
  getProductOrderBy(String type) {
    firebaseFirestore
        .collection("products")
        .orderBy('price')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        Product product = Product.fromMap(doc.data());
        products.add(product);
      });
    });
  }

  updateProductData(String productID, Map<String, dynamic> data) {
    firebaseFirestore.collection(collection).doc(productID).update(data);
  }

  void addRateToProduct(RateModel rate, String productID) {
    try {
      productController.updateProductData(productID, {
        "rate": FieldValue.arrayUnion([
          {"id": rate.id, "rate": rate.rate, "comment": rate.comment}
        ])
      });
      Get.snackbar("Success", "Đánh giá của bạn: ${rate.comment}");
      getProducts();
    } catch (e) {
      Get.snackbar("Error", "Cannot rating, retry!");
    }
    update();
  }
}
