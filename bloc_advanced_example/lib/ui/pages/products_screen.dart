import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/product_item.dart';
import '../../blocs/products_bloc/products_bloc.dart';
import '../../blocs/cart_bloc/cart_bloc.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Badge(
                badgeContent: BlocBuilder<CartBloc, CartState>(
                  builder: (context, cartState) {
                    return Text('${(cartState as CartRefresh).itemCount}');
                  },
                ),
                badgeColor: Colors.orangeAccent,
                child: Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, productsState) {
          if (productsState is ProductInProgress) {
            return Center(child: CircularProgressIndicator());
          }

          if (productsState is ProductsFailure) {
            return Center(child: Text('Failure!'));
          }

          if (productsState is ProductsSuccess) {
            return ListView.builder(
              itemBuilder: (context, i) =>ProductItem(
                  product: productsState.products[i],
                ),
              itemCount: productsState.products.length,
            );
          }

          return Container();
        },
      ),
    );
  }
}
