import 'package:foodeoapp/MVC/model/kidsModel.dart';
import 'package:foodeoapp/MVC/model/product_model.dart';

class MockData {
  static List<ProductModel> dummyProducts = [
    ProductModel(
      id: 1,
      name: 'Product 1',
      description: 'Description for Product 1',
      image:
          'https://hips.hearstapps.com/hmg-prod/images/20190503-delish-pineapple-baked-salmon-horizontal-ehg-450-1557771120.jpg?resize=640:*',
      schoolId: 101,
      Price: 200,
      createDate: DateTime.now(),
      updateDate: DateTime.now(),
    ),
    ProductModel(
      id: 2,
      name: 'Product 2',
      description: 'Description for Product 2',
      image:
          'https://res.cloudinary.com/hz3gmuqw6/image/upload/c_fill,q_auto,w_750/f_auto/boston-foods-phpvjFhsw',
      schoolId: 102,
      Price: 200,
      createDate: DateTime.now(),
      updateDate: DateTime.now(),
    ),
    ProductModel(
      id: 3,
      name: 'Product 3',
      description: 'Description for Product 3',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSe58WjgBSSLVcZlFZ_iox7A2Es_r36tpC3XA&usqp=CAU',
      schoolId: 103,
      Price: 200,
      createDate: DateTime.now(),
      updateDate: DateTime.now(),
    ),
    ProductModel(
      id: 4,
      name: 'Product 4',
      description: 'Description for Product 3',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE_wMNdu5CYNi1OLqE6zXb9PZ5iwG_WoRJNg&usqp=CAU',
      schoolId: 103,
      Price: 200,
      createDate: DateTime.now(),
      updateDate: DateTime.now(),
    ),
    ProductModel(
      id: 5,
      name: 'Product 3',
      description: 'Description for Product 3',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE_wMNdu5CYNi1OLqE6zXb9PZ5iwG_WoRJNg&usqp=CAU',
      schoolId: 103,
      Price: 200,
      createDate: DateTime.now(),
      updateDate: DateTime.now(),
    ),
  ];

  static List<KidsModel> dummyKidsData = [
    KidsModel(
      id: 1,
      name: 'John Doe',
      
      parentId: 101,
      schoolId: 201,
      schoolName: 'ABC School',
      createDate: DateTime.now(),
      updateDate: DateTime.now(),
    ),
    KidsModel(
      id: 2,
      name: 'Jane Smith',
      
      parentId: 102,
      schoolId: 202,
      schoolName: 'XYZ School',
      createDate: DateTime.now(),
      updateDate: DateTime.now(),
    ),
    // Add more dummy data as needed
  ];
}
