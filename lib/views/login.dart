import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrchat_dart/vrchat_dart.dart';
import 'package:vrctools/views/home.dart';
import 'package:vrctools/views/register.dart';
import 'package:vrctools/views/two_factor.dart';

class LoginView extends StatefulWidget {
  final VrchatDart api;
  const LoginView(this.api, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginViewState();
  }
}

class _LoginViewState extends State<LoginView> {
  late final SharedPreferences pref;
  final _loginFormKey = GlobalKey<FormState>();
  bool _isPasswordObscured = true;
  bool _isLoading = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? _shouldSaveCredentials = false;

  _LoginViewState() {
    SharedPreferences.getInstance().then((value) => pref = value);
  }

  void login() {
    setState(() {
      _isLoading = true;
    });

    if (_loginFormKey.currentState!.validate()) {
      widget.api.auth
          .login(
              username: usernameController.value.text,
              password: passwordController.value.text)
          .then((value) {
        if (value.response?.data is CurrentUser) {
          pref.setStringList("saved_credentials", [
            ...(pref.getStringList("saved_credentials") ?? []),
            "${usernameController.text}:${passwordController.text}"
          ]);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeView(widget.api)),
              (route) => false);
        } else if (value.response?.data.containsKey("requiresTwoFactorAuth")) {
          pref.setStringList("saved_credentials", [
            ...(pref.getStringList("saved_credentials") ?? []),
            "${usernameController.text}:${passwordController.text}"
          ]);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TwoFactorView(widget.api)));
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      });
      /*  
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill input')),
        );
      */
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void register() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => RegisterView(widget.api)));
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
                    Text("Login",
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center),
                    Text(
                      "Login into your VRChat account.",
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                              label: Text("Username / Email"),
                              prefixIcon: Icon(Icons.account_circle_rounded)),
                          enabled: !_isLoading,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a Username or Email Address.";
                            }

                            return null;
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                            controller: passwordController,
                            obscureText: _isPasswordObscured,
                            decoration: InputDecoration(
                                label: const Text("Password"),
                                prefixIcon: const Icon(Icons.password_rounded),
                                suffixIcon: IconButton(
                                  icon: Icon(_isPasswordObscured
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordObscured =
                                          !_isPasswordObscured;
                                    });
                                  },
                                )),
                            enabled: !_isLoading,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a Password.";
                              }

                              return null;
                            })),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: GestureDetector(
                            child: Row(children: [
                              Checkbox(
                                value: _shouldSaveCredentials,
                                onChanged: (value) {
                                  setState(() {
                                    _shouldSaveCredentials = value;
                                  });
                                },
                              ),
                              Text("Save Credentials",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.apply(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant))
                            ]),
                            onTap: () {})),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: _isLoading ? null : register,
                              child: const Text("Create Account"),
                            ),
                            FilledButton(
                                onPressed: _isLoading ? null : login,
                                child: const Text("Login"))
                          ],
                        ))
                  ]))),
    );
  }
}
