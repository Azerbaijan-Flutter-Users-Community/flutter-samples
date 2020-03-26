import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:why_bloc/counter_bloc.dart';
import 'package:why_bloc/custom_container.dart';
import 'counter_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => CounterBloc(),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomContainer(),
            SizedBox(
              height: 10,
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterBloc, int>(
              builder: (context, int state) {
                return Text(
                  '$state',
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => BlocProvider.of<CounterBloc>(context).add(
          CounterEvent.Increment,
        ),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
