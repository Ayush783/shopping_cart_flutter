import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String name;
  final String img;
  final String desc;
  final double price;

  const Item({
    required this.name,
    required this.img,
    required this.desc,
    required this.price,
  });

  Item.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        img = 'assets/dummy/${json['img']}',
        desc = json['desc'],
        price = json['price'];

  Item copyWith(Item i) {
    return Item(name: i.name, img: i.img, desc: i.desc, price: i.price);
  }

  @override
  List<Object?> get props => [name, img, desc, price];
}

class ItemResponse {
  final List<Item> items;
  final bool hasError;
  final String errorMessage;

  ItemResponse(this.items, this.hasError, this.errorMessage);

  ItemResponse.success(List<Item> data)
      : items = data,
        hasError = false,
        errorMessage = 'NO_ERROR';

  ItemResponse.failure(String msg)
      : hasError = true,
        errorMessage = msg,
        items = [];
}
