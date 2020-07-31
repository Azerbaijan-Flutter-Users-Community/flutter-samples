import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './ui/pages/products_screen.dart';
import './blocs/products_bloc/products_bloc.dart';
import './blocs/cart_bloc/cart_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartBloc>(
      create: (_) => CartBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocProvider<ProductsBloc>(
          create: (_) => ProductsBloc()..add(LoadProductsRequested()),
          child: ProductScreen(),
        ),
      ),
    );
  }
}
