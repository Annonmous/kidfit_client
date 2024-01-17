class CartModel {
  int kid_Id;
  int parentId;
  int product_id;
  String Kid_name;
  String product_name;
  String product_image;

  CartModel({
    required this.kid_Id,
    required this.parentId,
    required this.product_id,
    required this.Kid_name,
    required this.product_name,
    required this.product_image,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      kid_Id: json['kid_Id'] ?? '',
      parentId: json['parentId'] ?? '',
      product_id: json['product_id'] ?? '',
      product_name: json['product_name'] ?? '',
      product_image: json['product_image'] ?? '',
      Kid_name: json['Kid_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kid_Id': kid_Id,
      'parentId': parentId,
      'product_id': product_id,
      'product_name': product_name,
      'product_image': product_image,
    };
  }
}
