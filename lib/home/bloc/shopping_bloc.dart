import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cart/home/services/home_service.dart';
import 'package:equatable/equatable.dart';

import '../model/item.dart';

part 'shopping_event.dart';
part 'shopping_state.dart';

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {
  ShoppingBloc() : super(const ShoppingState()) {
    on<LoadItems>(_onLoadItems);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<CheckOut>(_onCheckOut);
  }

  final HomeApiFacade _api = HomeApiFacade();

  void _onLoadItems(LoadItems event, Emitter emit) async {
    emit(state.copyWith(loading: true));
    final itemResponse = await _api.loadItems();
    if (itemResponse.hasError) {
      emit(state.copyWith(hasError: true));
    } else {
      emit(state.copyWith(items: itemResponse.items));
    }
  }

  void _onAddToCart(AddToCart event, Emitter emit) async {
    final Map<Item, int> newCartItems = Map.from(state.cartItems);
    newCartItems.update(
      event.item,
      (value) => value + 1,
      ifAbsent: () => 1,
    );

    log(newCartItems.toString());

    emit(state.copyWith(
      cartItems: newCartItems,
    ));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter emit) async {
    final Map<Item, int> newCartItems = Map.from(state.cartItems);
    if (newCartItems[event.item] == 1) {
      newCartItems.remove(event.item);
    } else {
      newCartItems.update(event.item, (value) => value - 1);
    }

    log(newCartItems.toString());

    emit(
      state.copyWith(
        cartItems: newCartItems,
      ),
    );
  }

  void _onCheckOut(CheckOut event, Emitter emit) async {
    emit(state.copyWith(checkingOut: CheckoutStatus.inProcess));
    final response = await _api.checkOut(state.cartItems);
    if (response) {
      emit(
          state.copyWith(cartItems: {}, checkingOut: CheckoutStatus.completed));
    } else {
      emit(state.copyWith(checkingOut: CheckoutStatus.failed));
    }
  }
}
