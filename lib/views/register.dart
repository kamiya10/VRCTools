import 'package:flutter/material.dart';
import 'package:vrchat_dart/vrchat_dart.dart';
import 'package:vrctools/views/home.dart';
import 'package:vrctools/views/login.dart';

class RegisterPage extends StatefulWidget {
  final VrchatDart api;
  const RegisterPage(this.api, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  void login() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage(widget.api)));
  }

  void register() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage(widget.api)),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Register",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center),
              Text(
                "Register .",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text("Username")),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Email"),
                ),
              ),
              TextFormField(
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
              ),
              TextFormField(
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
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: login, child: const Text("Login")),
                      FilledButton(
                          onPressed: register, child: const Text("Register"))
                    ],
                  ))
            ]),
      ),
    );
  }
}
