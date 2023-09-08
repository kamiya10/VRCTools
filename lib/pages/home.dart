import 'package:flutter/material.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class HomePage extends StatefulWidget {
  final VrchatDart api;
  const HomePage(this.api, {super.key});
  
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(8),
    child: Column(
      children: [
        Card(
          child: Padding(padding: const EdgeInsets.all(16),
          child: Row(children: [
            Text("Online Friends", style: Theme.of(context).textTheme.labelLarge),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: BoxShape.circle
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text("${widget.api.auth.currentUser?.onlineFriends?.length}"),
              ),
            )]),
        ))
      ],
    ));
}