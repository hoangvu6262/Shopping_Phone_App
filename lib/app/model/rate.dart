class RateModel {
  static const ID = "id";
  static const RATE = "rate";
  static const COMMENT = "comment";

  String id;
  double rate;
  String comment;

  RateModel({
    this.id,
    this.rate,
    this.comment,
  });

  RateModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    rate = data[RATE];
    comment = data[COMMENT];
  }

  Map toJson() => {
        ID: id,
        RATE: rate,
        COMMENT: comment,
      };
}
