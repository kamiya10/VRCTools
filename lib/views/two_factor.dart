import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vrchat_dart/vrchat_dart.dart';
import 'package:vrctools/views/home.dart';
import 'package:vrctools/widgets/otp_input.dart';

class TwoFactorView extends StatefulWidget {
  final VrchatDart api;
  const TwoFactorView(this.api, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _TwoFactorViewState();
  }
}

class _TwoFactorViewState extends State<TwoFactorView> {
  final _twoFactorFormKey = GlobalKey<FormState>();
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();

  void verify() {
    widget.api.auth
        .verify2fa(
            "${_fieldOne.text}${_fieldTwo.text}${_fieldThree.text}${_fieldFour.text}${_fieldFive.text}${_fieldSix.text}")
        .then((value) {
      inspect(value.response?.data);
      if (value.response?.statusCode == 200) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeView(widget.api)),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _twoFactorFormKey,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Two Factor Authorization",
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center),
                  Text(
                    "Enter a numeric code from your authenticator app.",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          OtpInput(controller: _fieldOne, autoFocus: true),
                          OtpInput(controller: _fieldTwo, autoFocus: false),
                          OtpInput(controller: _fieldThree, autoFocus: false),
                          OtpInput(controller: _fieldFour, autoFocus: false),
                          OtpInput(controller: _fieldFive, autoFocus: false),
                          OtpInput(
                              controller: _fieldSix,
                              autoFocus: false,
                              submitCallback: verify),
                        ],
                      ))
                ]),
          )),
    );
  }
}
