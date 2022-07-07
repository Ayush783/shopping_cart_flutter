part of 'shopping_bloc.dart';

abstract class ShoppingEvent extends Equatable {
  const ShoppingEvent();

  @override
  List<Object> get props => [];
}

class LoadItems extends ShoppingEvent {}

class AddToCart extends ShoppingEvent {
  final Item item;

  const AddToCart(this.item);
}

class RemoveFromCart extends ShoppingEvent {
  final Item item;

  const RemoveFromCart(this.item);
}

class CheckOut extends ShoppingEvent {}
