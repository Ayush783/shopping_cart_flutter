part of 'shopping_bloc.dart';

class ShoppingState extends Equatable {
  const ShoppingState({
    this.loading = true,
    this.hasError = false,
    this.items = const [],
    this.cartItems = const {},
    // this.adding = false,
    // this.removing = false,
  });

  final Map<Item, int> cartItems;
  final List<Item> items;
  final bool hasError;
  final bool loading;
  // final bool adding;
  // final bool removing;

  ShoppingState copyWith({
    bool loading = false,
    bool hasError = false,
    Map<Item, int>? cartItems,
    // bool adding = false,
    // bool removing = false,
    List<Item>? items,
  }) {
    return ShoppingState(
      loading: loading,
      cartItems: cartItems ?? this.cartItems,
      hasError: hasError,
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [
        loading,
        // adding,
        cartItems,
        hasError,
        // removing,
        items,
      ];
}
