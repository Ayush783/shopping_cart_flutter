import 'package:cart/home/bloc/shopping_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/widget/item_card.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = context.select((ShoppingBloc bloc) {
      double sum = 0;
      bloc.state.cartItems.forEach((key, value) {
        sum += key.price * value;
      });
      return sum;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFB8E48),
        title: const Text('Your Cart'),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(child: BlocBuilder<ShoppingBloc, ShoppingState>(
              builder: (context, state) {
                if (state.cartItems.isEmpty) {
                  return const Center(
                    child: Text('No items added to cart yet'),
                  );
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) =>
                        ItemCard(item: state.cartItems.keys.elementAt(index)),
                    itemCount: state.cartItems.length,
                  );
                }
              },
            )),
            const SizedBox(height: 20),
            Align(
                alignment: Alignment.centerRight,
                child: Text('Total: \$$total')),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () {},
                    fillColor: const Color(0xffFB8E48),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: const Text(
                      'Checkout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
