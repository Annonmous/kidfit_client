class ProductModel {
  int id;
  String name;
  String description;
  String image;
  int schoolId;
  int Price;
  DateTime createDate;
  DateTime updateDate;
  final SchoolModel? school;
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.schoolId,
    required this.Price,
    required this.createDate,
    required this.updateDate,
     this.school,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['productsName'],
      description: json['productsName'],
      image: json['image'] == null ? '' : json['image'],
      Price: int.parse(json['productsPrice']),
      schoolId: json['schoolId'],
      createDate: DateTime.parse(json['createdAt']),
      updateDate: DateTime.parse(json['updatedAt']),
      school: SchoolModel.fromJson(json['school']),
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

class SchoolModel {
  final int id;
  final String name;
  final String password;
  final String email;
  final String role;
  final String createdAt;
  final String updatedAt;

  SchoolModel({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SchoolModel.fromJson(Map<String, dynamic> json) {
    return SchoolModel(
      id: json['id'],
      name: json['name'],
      password: json['password'],
      email: json['email'],
      role: json['role'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
