import 'package:flutter/material.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class FeedPage extends StatefulWidget {
  final VrchatDart api;
  const FeedPage(this.api, {super.key});
  
  @override
  State<StatefulWidget> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) => Expanded(child: Padding(
    padding: const EdgeInsets.all(8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Coming Soon", textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleLarge),
        Text("This page is still under construction.", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge!.apply(color: Theme.of(context).colorScheme.onSurfaceVariant),)
      ],
    )));
}