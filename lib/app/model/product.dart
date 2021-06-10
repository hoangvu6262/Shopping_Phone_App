import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  static const ID = "id";
  static const TITLE = "title";
  static const DESCRIPTION = "description";
  static const PRICE = "price";
  static const IMAGE_URL = "imageUrl";
  static const CATEGORY = "category";
  static const RATE = "rate";

  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  String category;
  List rate;

  Product(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.imageUrl,
      this.category,
      this.rate});

  Product.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    title = data[TITLE];
    description = data[DESCRIPTION];
    price = data[PRICE].toDouble();
    imageUrl = data[IMAGE_URL];
    category = data[CATEGORY];
    rate = data[RATE];
  }

  Product.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    title = documentSnapshot['title'] ?? [];
    price = documentSnapshot['price'] ?? [];
  }
}
