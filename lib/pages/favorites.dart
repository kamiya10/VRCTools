import 'package:flutter/material.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class FavoritePage extends StatefulWidget {
  final VrchatDart api;
  const FavoritePage(this.api, {super.key});
  
  @override
  State<StatefulWidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) => Expanded(child: Padding(
    padding: const EdgeInsets.all(8),
    child: Column(
      children: [
        Text("Avatars (${widget.api.auth.currentUser})")
      ],
    )));
}