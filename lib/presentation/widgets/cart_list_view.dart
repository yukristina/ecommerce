import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/data/models/cart/cart_item_model.dart';
import 'package:ecommerce/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/logic/services/formatter.dart';
import 'package:ecommerce/presentation/widgets/link_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';

class CartListView extends StatelessWidget {
  const CartListView(
      {super.key,
      required this.items,
      this.shrinkWrap = false,
      this.noScroll = false});

  final List<CartItemModel> items;
  final bool shrinkWrap;
  final bool noScroll;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: (noScroll) ? const NeverScrollableScrollPhysics(): null,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: CachedNetworkImage(imageUrl: item.product!.images![0]),
          title: Text(item.product!.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${Formatter.formatPrice(item.product!.price)} X ${item.quantity} = ${Formatter.formatPrice(item.product!.price * item.quantity)}"),
              LinkButton(
                onPressed: () {
                  BlocProvider.of<CartCubit>(context)
                      .removeFromCart(item.product!);
                },
                color: Colors.red,
                text: 'Delete',
              ),
            ],
          ),
          trailing: InputQty(
            minVal: 1,
            maxVal: 99,
            initVal: item.quantity,
            showMessageLimit: false,
            onQtyChanged: (value) {
              BlocProvider.of<CartCubit>(context)
                  .addToCart(item.product!, value as int);
            },
          ),
        );
      },
    );
  }
}
