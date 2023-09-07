import 'package:flutter/material.dart';
import 'package:vrchat_dart/vrchat_dart.dart';
import 'package:vrctools/api/vrc_api_container.dart';
import 'package:vrctools/views/home.dart';
import 'package:vrctools/views/login.dart';

late final VrchatDart api;

Future<void> main() async {
  api = await VrcApiContainer().create();
  await api.auth.login();
  runApp(const VRCTools());
}

class VRCTools extends StatelessWidget {
  const VRCTools({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "VRCTools",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: api.auth.currentUser == null ? "login" : "/",
      routes: {
        "/": (context) => HomeView(api),
        "login": (context) => LoginView(api),
      },
    );
  }
}
