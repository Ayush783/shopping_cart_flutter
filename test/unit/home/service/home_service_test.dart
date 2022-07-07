import 'package:cart/home/model/item.dart';
import 'package:cart/home/services/home_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests for home service', () {
    late final HomeApi api;
    setUp(() {
      api = HomeApi();
    });
    test('check output of load items', () {
      expect(api.loadItems(), completion(isA<ItemResponse>()));
    });
  });
}
