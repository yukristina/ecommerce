import 'dart:async';

import 'package:ecommerce/data/models/cart/cart_item_model.dart';
import 'package:ecommerce/data/models/product/product_model.dart';
import 'package:ecommerce/data/repositories/cart_repository.dart';
import 'package:ecommerce/logic/cubits/cart_cubit/cart_state.dart';
import 'package:ecommerce/logic/cubits/user_cubit.dart';
import 'package:ecommerce/logic/cubits/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final UserCubit _userCubit;
  StreamSubscription? _userSubscription;

  CartCubit(this._userCubit) : super(CartInitialState()) {
    // initial value
    _handleUserState(_userCubit.state);

    // listening to user cubit (for future updates)
    _userSubscription = _userCubit.stream.listen(_handleUserState);
  }

  void _handleUserState(UserState userState) {
    if (userState is UserLoggedInState) {
      _initialize(userState.userModel.id);
    } else if (userState is UserLoggedOutState) {
      emit(CartInitialState());
    }
  }

  final _cartRepository = CartRepository();

  void _initialize(String userId) async {
    emit(CartLoadingState(state.items));
    try {
      final items = await _cartRepository.fetchCartForUser(userId);
      emit(CartLoadedState(items));
    } catch (e) {
      emit(CartErrorState(e.toString(), state.items));
    }
  }

  void addToCart(ProductModel product, int quantity) async {
    emit(CartLoadingState(state.items));

    try {
      if (_userCubit.state is UserLoggedInState) {
        UserLoggedInState userState = _userCubit.state as UserLoggedInState;
        CartItemModel newItem =
            CartItemModel(product: product, quantity: quantity);
        final items =
            await _cartRepository.addToCart(newItem, userState.userModel.id);
        emit(CartLoadedState(items));
      } else {
        throw "An error occured while adding the item";
      }
    } catch (e) {
      emit(CartErrorState(e.toString(), state.items));
    }
  }

   void removeFromCart(ProductModel product) async {
    emit(CartLoadingState(state.items));

    try {
      if (_userCubit.state is UserLoggedInState) {
        UserLoggedInState userState = _userCubit.state as UserLoggedInState;

        final items =
            await _cartRepository.removeFromCart(product.id, userState.userModel.id);
        emit(CartLoadedState(items));
      } else {
        throw "An error occured while removing the item";
      }
    } catch (e) {
      emit(CartErrorState(e.toString(), state.items));
    }
  }

  bool cartContains(ProductModel product) {
    if (state.items.isNotEmpty) {
      final foundItem =
          state.items.where((item) => item.product!.id == product.id).toList();
      if (foundItem.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  

  @override
  Future<void> close() {
    _userSubscription!.cancel();
    return super.close();
  }
}
