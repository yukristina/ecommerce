import 'dart:async';

import 'package:ecommerce/data/models/cart/cart_item_model.dart';
import 'package:ecommerce/data/models/order/order_model.dart';
import 'package:ecommerce/data/repositories/order_repository.dart';
import 'package:ecommerce/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/logic/cubits/order_cubit/order_state.dart';
import 'package:ecommerce/logic/cubits/user_cubit.dart';
import 'package:ecommerce/logic/cubits/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  final UserCubit _userCubit;
  final CartCubit _cartCubit;
  StreamSubscription? _userSubscription;
  OrderCubit(this._userCubit, this._cartCubit) : super(OrderInitialState()) {
    // initial value
    _handleUserState(_userCubit.state);

    // listening to user cubit (for future updates)
    _userSubscription = _userCubit.stream.listen(_handleUserState);
  }

  void _handleUserState(UserState userState) {
    if (userState is UserLoggedInState) {
      _initialize(userState.userModel.id);
    } else if (userState is UserLoggedOutState) {
      emit(OrderInitialState());
    }
  }

  final _orderRepository = OrderRepository();

  void _initialize(String userId) async {
    emit(OrderLoadingState(state.orders));
    try {
      final orders = await _orderRepository.fetchCartForUser(userId);
      emit(OrderLoadedState(orders));
    } catch (e) {
      emit(OrderErrorState(e.toString(), state.orders));
    }
  }

  Future<bool> createOrder({
    required List<CartItemModel> items,
    required String paymentMethod,
  }) async {
    emit(OrderLoadingState(state.orders));
    try {
      if (_userCubit.state is! UserLoggedInState) {
        return false;
      }

      OrderModel newOrder = OrderModel(
        status: (paymentMethod == 'pay-on-delivery')
            ? 'order-placed'
            : 'payment-pending',
        user: (_userCubit.state as UserLoggedInState).userModel,
        items: items,
      );
      final order = await _orderRepository.createOrders(newOrder);

      List<OrderModel> orders = [order,...state.orders];
      emit(OrderLoadedState(orders));

      // clear the cart
      _cartCubit.clearCart();
      return true;
    } catch (e) {
      emit(OrderErrorState(e.toString(), state.orders));
      return false;
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
