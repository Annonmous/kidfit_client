class CartModel {
  late int kidId;
  late int parentId;
  late int productId;
  late List<int> productIdsList;
  late String kidName;
  late String productName;
  late String productImage;
  late String productPrice;

  CartModel({
    required this.kidId,
    required this.parentId,
    required this.productId,
    required this.productIdsList,
    required this.productPrice,
    required this.kidName,
    required this.productName,
    required this.productImage,
  });
}
