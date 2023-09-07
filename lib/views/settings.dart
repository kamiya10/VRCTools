import 'package:flutter/material.dart';
import 'package:vrchat_dart/vrchat_dart.dart';
import 'package:vrctools/views/login.dart';

class SettingsView extends StatefulWidget {
  final VrchatDart api;
  const SettingsView(this.api, {super.key});

  @override
  State<StatefulWidget> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Settings")),
        body: ListView(children: [
          ListTile(
            leading: Icon(Icons.logout_rounded,
                color: Theme.of(context).colorScheme.error),
            title: Text("Logout",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: Theme.of(context).colorScheme.error)),
            onTap: () {
              widget.api.auth.logout();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => LoginView(widget.api)),
                  (route) => false);
            },
          )
        ]),
      );
}
