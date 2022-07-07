import 'package:cart/cart/cart.dart';
import 'package:cart/home/bloc/shopping_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../widget/item_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartCount =
        context.select((ShoppingBloc bloc) => bloc.state.cartItems.length);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFB8E48),
        title: const Text('ShopIt'),
        elevation: 2,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CartView()));
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/cart.svg',
                    height: 28,
                    color: Colors.white,
                  ),
                  Positioned(
                    right: 0,
                    top: 10,
                    child: AnimatedOpacity(
                      opacity: cartCount > 0 ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInCubic,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.red,
                        child: Center(
                          child: Text(
                            '$cartCount',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<ShoppingBloc, ShoppingState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (state.hasError) {
              return const Center(
                child: Text('An error occoured'),
              );
            } else {
              if (state.items.isEmpty) {
                return const Center(
                  child: Text('No items to show'),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) => ItemCard(
                      item: state.items[index],
                    ),
                    itemCount: state.items.length,
                  ),
                );
              }
            }
          }
        },
      ),
    );
  }
}
