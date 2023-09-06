import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vrchat_dart/vrchat_dart.dart';
import 'package:vrctools/views/login.dart';

class HomePage extends StatefulWidget {
  final VrchatDart api;
  const HomePage(this.api, {super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
