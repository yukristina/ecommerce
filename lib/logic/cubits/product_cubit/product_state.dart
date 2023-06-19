import 'package:ecommerce/data/models/product/product_model.dart';

abstract class ProductState{
  final List<ProductModel> products;
  ProductState(this.products);
  }

  class ProductInitialState extends ProductState {
  ProductInitialState() : super([]);
}

class ProductLoadingState extends ProductState {
  ProductLoadingState(super.categories);
}

class ProductLoadedState extends ProductState {
  ProductLoadedState(super.categories);
}

class ProductErrorState extends ProductState {
  final String message;
  ProductErrorState(this.message,super.categories);
}