class KidsModel {
  int id;
  String name;

  int parentId;
  int schoolId;
  String schoolName;
  DateTime createDate;
  DateTime updateDate;

  KidsModel({
    required this.id,
    required this.name,
    required this.parentId,
    required this.schoolId,
    required this.schoolName,
    required this.createDate,
    required this.updateDate,
  });

  factory KidsModel.fromJson(Map<String, dynamic> json) {
    return KidsModel(
      id: json['id'],
      name: json['name'],
      parentId: json['parent_id'],
      schoolId: json['school_id'],
      schoolName: json['schoolName'],
      createDate: DateTime.parse(json['createDate']),
      updateDate: DateTime.parse(json['updateDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parent_id': parentId,
      'school_id': schoolId,
      'schoolName': schoolName,
      'createDate': createDate.toIso8601String(),
      'updateDate': updateDate.toIso8601String(),
    };
  }
}
