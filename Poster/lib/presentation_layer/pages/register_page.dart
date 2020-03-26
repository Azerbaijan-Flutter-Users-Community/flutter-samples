import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poster/bloc_layer/authentication_bloc/authentication_bloc.dart';
import 'package:poster/bloc_layer/register_bloc/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state.isFailure) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Register Failure'), Icon(Icons.error)],
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
              }

              if (state.isSubmitting) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Regsiter Loading...'),
                          CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  );
              }

              if (state.isSuccess) {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      child: FlutterLogo(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                        labelText: 'email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autovalidate: true,
                      autocorrect: false,
                      validator: (_) {
                        return !state.isEmailValid ? 'Invalid Email' : null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        labelText: 'password',
                      ),
                      validator: (_) {
                        return !state.isPasswordValid
                            ? 'Invalid Password'
                            : null;
                      },
                      obscureText: true,
                      autovalidate: true,
                      autocorrect: false,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      onPressed: _isCreateAccountButtonEnabled(state)
                          ? () {
                              _onFormSubmitted();
                            }
                          : null,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(),
                        child: Center(
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  bool _isCreateAccountButtonEnabled(RegisterState state) =>
      state.isFormValid &&
      !state.isSubmitting &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  void _onEmailChanged() {
    BlocProvider.of<RegisterBloc>(context).add(
      EmailChanged(
        email: _emailController.text,
      ),
    );
  }

  void _onPasswordChanged() {
    BlocProvider.of<RegisterBloc>(context).add(
      PasswordChanged(
        password: _passwordController.text,
      ),
    );
  }

  void _onFormSubmitted() {
    BlocProvider.of<RegisterBloc>(context).add(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    _passwordController?.dispose();
    _passwordController?.dispose();
  }
}
