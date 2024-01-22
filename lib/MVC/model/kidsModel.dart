class KidsModel {
  final int id;
  final String name;
  final String classNo;
  final String image;
  final String createdAt;
  final String updatedAt;
  final int parentId;
  final int schoolId;

  KidsModel({
    required this.id,
    required this.name,
    required this.classNo,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.parentId,
    required this.schoolId,
  });

  factory KidsModel.fromJson(Map<String, dynamic> json) {
    return KidsModel(
      id: json['id'],
      name: json['name'],
      classNo: json['classNo'],
      image: json['image'] == null ? '' : json['image'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      parentId: json['parentId'],
      schoolId: json['schoolId'],
    );
  }
}
