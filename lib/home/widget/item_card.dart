import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/shopping_bloc.dart';
import '../model/item.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    final count = context
        .select((ShoppingBloc bloc) => bloc.state.cartItems[widget.item]);
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shadowColor: Colors.black.withOpacity(0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            height: 108,
            width: 84,
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(10)),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    widget.item.img,
                  ),
                )),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.item.name),
                Text(widget.item.desc),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.bounceInOut,
              switchOutCurve: Curves.bounceInOut,
              child: count != null && count > 0
                  ? Row(
                      children: [
                        IconButton(
                            iconSize: 16,
                            constraints: const BoxConstraints(
                                minWidth: 16, minHeight: 16),
                            padding: const EdgeInsets.all(4),
                            onPressed: () {
                              context
                                  .read<ShoppingBloc>()
                                  .add(RemoveFromCart(widget.item));
                            },
                            icon: const Icon(Icons.remove)),
                        Text(count.toString()),
                        IconButton(
                            iconSize: 16,
                            constraints: const BoxConstraints(
                                minWidth: 16, minHeight: 16),
                            padding: const EdgeInsets.all(4),
                            onPressed: () {
                              context
                                  .read<ShoppingBloc>()
                                  .add(AddToCart(widget.item));
                            },
                            icon: const Icon(Icons.add)),
                      ],
                    )
                  : GestureDetector(
                      onTap: () {
                        context
                            .read<ShoppingBloc>()
                            .add(AddToCart(widget.item));
                      },
                      child: SvgPicture.asset(
                        'assets/icons/cart_plus.svg',
                        height: 24,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
