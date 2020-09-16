import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_bloc_example/mock_pagination_bloc/mock_pagination_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pagination Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<MockPaginationBloc>(
        create: (_) => MockPaginationBloc()..add(NextPageFetchRequested()),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController scrollController = ScrollController();
  int itemCount = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.bloc<MockPaginationBloc>().add(NextPageFetchRequested());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mock Pagination with BLoC'),
      ),
      body: BlocBuilder<MockPaginationBloc, MockPaginationState>(
        builder: (context, state) {
          if (state.items == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) =>
                  _handleNotification(context, notification),
              child: ListView.builder(
                controller: scrollController,
                itemBuilder: (context, i) {
                  if (i >= state.items.length) {
                    return SizedBox(
                      height: 100,
                      child: CupertinoActivityIndicator(),
                    );
                  } else {
                    return SizedBox(
                      height: 200,
                      child: Card(
                        child: Center(
                          child: Text('$i item: ${state.items[i]}'),
                        ),
                      ),
                    );
                  }
                },
                itemCount: itemCount = calculateItemCount(state),
              ),
            );
          }
        },
      ),
    );
  }

  int calculateItemCount(MockPaginationState state) {
    if (state.reachedEndOfTheResults) {
      return state.items.length;
    } else {
      return state.items.length + 1;
    }
  }

  bool _handleNotification(
      BuildContext context, ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollEndNotification &&
        scrollController.position.extentAfter == 0) {
      context.bloc<MockPaginationBloc>().add(NextPageFetchRequested(itemCount));
    }

    return false;
  }
}
