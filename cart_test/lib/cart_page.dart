import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_bloc/cart_cubit.dart';
import 'cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartInUpdate) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Container(
                    height: 50,
                    child: Text('Reloading...'),
                  ),
                ),
              );
          }
        },
        builder: (context, state) {
          if (state is CartInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartFailure) {
            return Center(child: Text('ERROR!'));
          } else if (state is CartSuccess) {
            return ListView.builder(
              itemBuilder: (_, i) => CartItem(
                product: state.products[i],
              ),
              itemCount: state.products.length,
            );
          } else if (state is CartInUpdate) {
            return ListView.builder(
              itemBuilder: (_, i) => CartItem(
                product: state.products[i],
              ),
              itemCount: state.products.length,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
