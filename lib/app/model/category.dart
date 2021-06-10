class CategoryModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE_URL = "image";

  String id;
  String name;
  String image;

  CategoryModel({
    this.id,
    this.name,
    this.image,
  });

  CategoryModel.fromMap(Map data) {
    id = data[ID];
    name = data[NAME];
    image = data[IMAGE_URL];
  }
}
