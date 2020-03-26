import 'package:flutter/material.dart';
import 'package:learn_structure/core/constants/routes.dart';
import 'package:learn_structure/core/viewmodels/views/login_view_model.dart';
import 'package:provider/provider.dart';
import '../base_widget.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginViewModel>(
      model: LoginViewModel(authecticationService: Provider.of(context)),
      child: Column(
        children: <Widget>[
          Text('Login'),
          Text('Enter a nubmer between 1-10'),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter number',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Login View'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            child,
            model.busy
                ? CircularProgressIndicator()
                : RaisedButton(
                    onPressed: () async {
                      if (_controller.text != null ||
                          _controller.text.isNotEmpty) {
                        String query = _controller.text;
                        setState(() {
                          _controller.text = "";
                        });
                        final success = await model.login(query);

                        if (success) {
                          Navigator.pushNamed(context, Routes.Home);
                        } else {
                          print('unsuccessfull');
                        }
                      }
                    },
                    child: Text('Login'),
                  ),
          ],
        ),
      ),
    );
  }
}
