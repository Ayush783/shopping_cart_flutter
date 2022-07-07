import 'package:cart/home/model/item.dart';

abstract class HomeApiFacade {
  factory HomeApiFacade() {
    return HomeApi();
  }

  Future<ItemResponse> loadItems();

  Future<bool> checkOut(Map<Item, int> items);
}

class HomeApi implements HomeApiFacade {
  @override
  Future<bool> checkOut(Map<Item, int> items) async {
    await Future.delayed(const Duration(seconds: 3));
    return true;
  }

  @override
  Future<ItemResponse> loadItems() async {
    await Future.delayed(const Duration(seconds: 3));
    return ItemResponse.success(
      mockItemData
          .map(
            (e) => Item.fromJson(e),
          )
          .toList(),
    );
  }
}

const List<Map<String, dynamic>> mockItemData = [
  {
    'name': 'White Shirt',
    'img': '1.png',
    'desc': 'A very good white shirt',
    'price': 590.0,
  },
  {
    'name': 'Checkered Yellow Shirt',
    'img': '2.png',
    'desc': 'A very good checkered yellow shirt',
    'price': 720.0,
  },
  {
    'name': 'Plain White Shirt',
    'img': '3.png',
    'desc': 'A very good plain white shirt',
    'price': 300.0,
  },
  {
    'name': 'Jacket',
    'img': '4.png',
    'desc': 'A very good jacket',
    'price': 1140.0,
  },
  {
    'name': 'Designer Blue Shirt',
    'img': '5.png',
    'desc': 'A very good designer blue shirt',
    'price': 590.0,
  },
  {
    'name': 'Dark Blue Shirt',
    'img': '6.png',
    'desc': 'A very good dark blue shirt',
    'price': 590.0,
  },
  {
    'name': 'Casual Shirt',
    'img': '8.png',
    'desc': 'A very good casual shirt',
    'price': 590.0,
  },
  {
    'name': 'Light Blue Shirt',
    'img': '7.png',
    'desc': 'A very good light blue shirt',
    'price': 590.0,
  },
];
