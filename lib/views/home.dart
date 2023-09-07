import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vrchat_dart/vrchat_dart.dart';
import 'package:vrctools/views/login.dart';

class HomePage extends StatefulWidget {
  final VrchatDart api;
  const HomePage(this.api, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VRCTools"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("${widget.api.auth.currentUser!.displayName} ，歡迎回來！",
                style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
