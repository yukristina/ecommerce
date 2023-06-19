import 'package:ecommerce/data/models/product/product_model.dart';
import 'package:ecommerce/data/repositories/product_repository.dart';
import 'package:ecommerce/logic/cubits/product_cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()) {
    _initialize();
  }

  final _productRepository = ProductRepository();

  void _initialize() async {
    emit(ProductInitialState());
    try {
      List<ProductModel> categories =
          (await _productRepository.fetchAllProduct())
              .cast<ProductModel>()
              .toList();
      emit(ProductLoadedState(categories));
    } catch (e) {
      emit(ProductErrorState(e.toString(), state.products));
    }
  }
}
