import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopping_phone/app/constants/controllers.dart';
import 'package:shopping_phone/app/constants/firebase.dart';
import 'package:shopping_phone/app/model/category.dart';
import 'package:shopping_phone/app/model/product.dart';
import 'package:shopping_phone/app/ui/page/home/product_page.dart';

class CategoryController extends GetxController {
  static CategoryController instance = Get.find();
  String collection = "categories";

  RxList<CategoryModel> categories = RxList<CategoryModel>();
  RxList<Product> products = RxList<Product>();
  RxList<Product> temp = RxList<Product>();

  @override
  void onReady() {
    super.onReady();
    getCategories();
  }

  // Get categories from Firebase
  void getCategories() {
    categories.clear();
    firebaseFirestore
        .collection(collection)
        .where("userId", isEqualTo: userController.userModel.value.id)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        CategoryModel category = CategoryModel.fromMap(doc.data());
        categories.add(category);
        update();
      });
    });
  }

  // Get categories from Firebase - Realtime
  Stream<QuerySnapshot> getCategoryRealTime() {
    categories.clear();
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
      Get.to(ProductPage(category: category, products: products));
    });
  }

  // Order by product
  getProductOrderBy(String type) {
    // print("MS shop vao day");
    firebaseFirestore
        .collection("products")
        .orderBy('price')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        Product product = Product.fromMap(doc.data());
        temp.add(product);
        // print("MS Shop price ${product.price}");
        update();
      });
    });
  }
}
