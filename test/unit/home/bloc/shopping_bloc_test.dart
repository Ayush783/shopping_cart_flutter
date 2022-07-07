import 'package:bloc_test/bloc_test.dart';
import 'package:cart/home/bloc/shopping_bloc.dart';
import 'package:cart/home/model/item.dart';
import 'package:cart/home/services/home_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Shopping bloc tests', () {
    final bloc = ShoppingBloc();

    test('initial state check', () {
      expect(bloc.state, equals(const ShoppingState()));
    });

    blocTest<ShoppingBloc, ShoppingState>('Add item to cart.',
        build: () => ShoppingBloc(),
        act: (bloc) => bloc.add(AddToCart(Item.fromJson(mockItemData[0]))),
        verify: (bloc) {
          expect(bloc.state.cartItems.length, equals(1));
        });

    blocTest<ShoppingBloc, ShoppingState>('Remove item from cart.',
        build: () => ShoppingBloc(),
        act: (bloc) {
          bloc.add(AddToCart(Item.fromJson(mockItemData[0])));
          bloc.add(RemoveFromCart(Item.fromJson(mockItemData[0])));
        },
        verify: (bloc) {
          expect(bloc.state.cartItems.length, equals(0));
        });
  });
}
