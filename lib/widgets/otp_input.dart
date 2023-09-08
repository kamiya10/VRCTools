import 'package:flutter/material.dart';

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  final Function? submitCallback;
  const OtpInput(
      {super.key,
      required this.controller,
      required this.autoFocus,
      this.submitCallback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 40,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        showCursor: false,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
            counterText: "",
            hintText: "0",
            hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(40),
                fontSize: 20)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else if (autoFocus == false) {
            FocusScope.of(context).previousFocus();
          }

          submitCallback?.call();
        },
      ),
    );
  }
}
