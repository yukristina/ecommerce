import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/data/models/user_model.dart';
import 'package:ecommerce/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/logic/cubits/cart_cubit/cart_state.dart';
import 'package:ecommerce/logic/cubits/order_cubit/order_cubit.dart';
import 'package:ecommerce/logic/cubits/user_cubit.dart';
import 'package:ecommerce/logic/cubits/user_state.dart';
import 'package:ecommerce/presentation/screens/order/order_placed_screen.dart';
import 'package:ecommerce/presentation/screens/order/providers/order_detail_provider.dart';
import 'package:ecommerce/presentation/screens/user/edit_profile_screen.dart';
import 'package:ecommerce/presentation/widgets/cart_list_view.dart';
import 'package:ecommerce/presentation/widgets/gap_widget.dart';
import 'package:ecommerce/presentation/widgets/link_button.dart';
import 'package:ecommerce/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  static const String routeName = "order_detail";

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Order'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is UserLoggedInState) {
                  UserModel user = state.userModel;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Details',
                        style: TextStyles.body2
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const GapWidget(),
                      Text(
                        user.fullName,
                        style: TextStyles.heading3,
                      ),
                      Text(
                        'Email: ${user.email}',
                        style: TextStyles.body2,
                      ),
                      Text(
                        'Phone: ${user.phoneNumber}',
                        style: TextStyles.body2,
                      ),
                      Text(
                        'Adress: ${user.city}',
                        style: TextStyles.body2,
                      ),
                      LinkButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, EditProfileScreen.routeName);
                          },
                          text: 'Edit Profile'),
                    ],
                  );
                }
                if (state is UserErrorState) {
                  return Text(state.message);
                }
                return const SizedBox();
              },
            ),
            const GapWidget(
              size: 10,
            ),
            Text(
              'Items',
              style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
            ),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartLoadingState && state.items.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is CartErrorState && state.items.isEmpty) {
                  return Text(state.message);
                }

                return CartListView(
                  items: state.items,
                  shrinkWrap: true,
                  noScroll: true,
                );
              },
            ),
            const GapWidget(
              size: 10,
            ),
            Text(
              'Payment',
              style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
            ),
            const GapWidget(),
            Consumer<OrderDetailProvider>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    RadioListTile(
                      value: 'pay-on-delivery',
                      contentPadding: EdgeInsets.zero,
                      groupValue: value.paymentMethod,
                      title: const Text('Pay on Delivery'),
                      onChanged: value.changePaymentMethod,
                    ),
                    RadioListTile(
                      value: 'pay-now',
                      groupValue: value.paymentMethod,
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Pay Now'),
                      onChanged: value.changePaymentMethod,
                    ),
                  ],
                );
              },
            ),
            const GapWidget(),
            PrimaryButton(
                onPressed: () async {
                  bool success =
                      await BlocProvider.of<OrderCubit>(context).createOrder(
                    items: BlocProvider.of<CartCubit>(context).state.items,
                    paymentMethod:
                        Provider.of<OrderDetailProvider>(context, listen: false)
                            .paymentMethod
                            .toString(),
                  );

                  if (success) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushNamed(
                        context, OrderPlacedScreen.routeName);
                  }
                },
                text: 'Place Order'),
          ],
        ),
      ),
    );
  }
}
