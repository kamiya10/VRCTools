import 'package:flutter/material.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class UserView extends StatefulWidget {
  final VrchatDart api;
  final dynamic user;
  const UserView(this.api, this.user, {super.key});

  @override
  State<StatefulWidget> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.user.displayName)),
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              Text(widget.user.displayName),
            ])));
  }
}
