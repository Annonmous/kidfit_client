class ProductModel {
  int id;
  String name;
  String description;
  String image;
  int schoolId;
  int Price;
  DateTime createDate;
  DateTime updateDate;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.schoolId,
    required this.Price,
    required this.createDate,
    required this.updateDate,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      Price: json['Price'],
      schoolId: json['school_id'],
      createDate: DateTime.parse(json['createDate']),
      updateDate: DateTime.parse(json['updateDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'Price': Price,
      'school_id': schoolId,
      'createDate': createDate.toIso8601String(),
      'updateDate': updateDate.toIso8601String(),
    };
  }
}
