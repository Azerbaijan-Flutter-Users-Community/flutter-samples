import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poster/bloc_layer/authentication_bloc/authentication_bloc.dart';
import 'package:poster/bloc_layer/login_bloc/login_bloc.dart';
import 'package:poster/constants/routes.dart';
import 'package:poster/presentation_layer/widgets/theme_changer.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      appBar: AppBar(
        title: Text('login'),
        actions: <Widget>[
          ThemeChanger(),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.isFailure) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Login Failure'), Icon(Icons.error)],
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
                          Text('Logging In...'),
                          CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  );
              }

              if (state.isSuccess) {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
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
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        child: Text('Create Account'),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(Routes.CREATE_ACCOUNT);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      onPressed: _isLoginButtonEnabled(state)
                          ? () {
                              _onFormSubmitted();
                            }
                          : null,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(),
                        child: Center(
                          child: Text(
                            'Log in',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      onPressed: _isSignInWithGoogleEnabled(state)
                          ? _onGoogleSignInCliked
                          : null,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(),
                        child: Center(
                          child: Text(
                            'Sign in with Google',
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

  bool _isLoginButtonEnabled(LoginState state) =>
      state.isFormValid &&
      !state.isSubmitting &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  bool _isSignInWithGoogleEnabled(LoginState state) =>
      (!state.isEmailValid || !state.isPasswordValid) ||
      _emailController.text.isEmpty ||
      _passwordController.text.isEmpty;

  void _onEmailChanged() {
    BlocProvider.of<LoginBloc>(context).add(
      EmailChanged(
        email: _emailController.text,
      ),
    );
  }

  void _onPasswordChanged() {
    BlocProvider.of<LoginBloc>(context).add(
      PasswordChanged(
        password: _passwordController.text,
      ),
    );
  }

  void _onFormSubmitted() {
    BlocProvider.of<LoginBloc>(context).add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  void _onGoogleSignInCliked() {
    BlocProvider.of<LoginBloc>(context).add(
      LoginWithGooglePressed(),
    );
  }
}
