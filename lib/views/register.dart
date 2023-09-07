import 'package:flutter/material.dart';
import 'package:vrchat_dart/vrchat_dart.dart';
import 'package:vrctools/views/home.dart';
import 'package:vrctools/views/login.dart';

class RegisterView extends StatefulWidget {
  final VrchatDart api;
  const RegisterView(this.api, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterViewState();
  }
}

class _RegisterViewState extends State<RegisterView> {
  final _loginFormKey = GlobalKey<FormState>();
  String _password = "";
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void login() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginView(widget.api)));
  }

  void register() {
    if (_loginFormKey.currentState!.validate()) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeView(widget.api)),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _loginFormKey,
            child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Register",
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center),
                      Text(
                        "Register a VRChat account.",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(label: Text("Username")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a Username";
                          } else if (value.length < 4) {
                            return "Username must have at least 4 characters.";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text("Email"),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter an Email";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _isPasswordObscured,
                        decoration: InputDecoration(
                            label: const Text("Password"),
                            suffixIcon: IconButton(
                              icon: Icon(_isPasswordObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isPasswordObscured = !_isPasswordObscured;
                                });
                              },
                            )),
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a Password";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _isConfirmPasswordObscured,
                        decoration: InputDecoration(
                            label: const Text("Confirm Password"),
                            suffixIcon: IconButton(
                              icon: Icon(_isConfirmPasswordObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordObscured =
                                      !_isConfirmPasswordObscured;
                                });
                              },
                            )),
                        validator: (value) {
                          if (value != _password) {
                            return "Password doesn't match.";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: login,
                                    child: const Text("Login")),
                                FilledButton(
                                    onPressed: register,
                                    child: const Text("Register"))
                              ]))
                    ]))));
  }
}
