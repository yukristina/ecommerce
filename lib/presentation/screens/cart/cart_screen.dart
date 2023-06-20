import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/logic/cubits/cart_cubit/cart_state.dart';
import 'package:ecommerce/logic/services/calculations.dart';
import 'package:ecommerce/logic/services/formatter.dart';
import 'package:ecommerce/presentation/widgets/link_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const String routeName = "cart_screen";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("cart"),
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoadingState && state.items.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CartErrorState && state.items.isEmpty) {
              return Center(
                child: Text(state.message),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return ListTile(
                        leading: CachedNetworkImage(
                            imageUrl: item.product!.images![0]),
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.items.length.toString(),
                              style: TextStyles.body1
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Total : ${Formatter.formatPrice(Calculations.cartTotal(state.items))}",
                              style: TextStyles.heading3,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: CupertinoButton(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width / 22),
                          color: AppColors.accent,
                          child: const Text("Place Order"),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
