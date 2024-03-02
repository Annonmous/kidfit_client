class CartModel {
  late int kidId;
  late int parentId;
  late int schoolId;
  late int productId;
  late int quantity;
  late String kidName;
  late String productName;
  late String productImage;
  late String productPrice;

  CartModel({
    required this.kidId,
    required this.parentId,
    required this.schoolId,
    required this.productId,
    required this.quantity,
    required this.productPrice,
    required this.kidName,
    required this.productName,
    required this.productImage,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      kidId: json['kidId'],
      parentId: json['parentId'],
      schoolId: json['schoolId'],
      productId: json['productId'],
      quantity: json['quantity'],
      productPrice: json['productPrice'],
      kidName: json['kidName'],
      productName: json['productName'],
      productImage: json['productImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      "name": productName,
      "imageData": productImage,
      "price": productPrice,
      "quantity": 1
    };
  }
}
