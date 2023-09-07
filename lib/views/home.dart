import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class HomeView extends StatefulWidget {
  final VrchatDart api;
  const HomeView(this.api, {super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  Future<NetworkImage> getImage(String url) async {
    return widget.api.rawApi.dio.get(url).then((res) {
      return NetworkImage(res.redirects.last.location.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("VRCTools"),
          actions: [
            FutureBuilder<NetworkImage>(
              future: getImage(
                  widget.api.auth.currentUser!.currentAvatarThumbnailImageUrl),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CircleAvatar(backgroundImage: snapshot.data);
                } else {
                  return const CircleAvatar(child: Icon(Icons.person));
                }
              },
            )
          ],
        ),
        bottomNavigationBar: MediaQuery.of(context).size.width < 640
            ? NavigationBar(
                selectedIndex: _selectedIndex,
                elevation: 3,
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.home), label: "Home"),
                  NavigationDestination(icon: Icon(Icons.feed), label: "Feed"),
                  NavigationDestination(
                      icon: Icon(Icons.favorite), label: "Favorites"),
                  NavigationDestination(
                      icon: Icon(Icons.settings), label: "Settings"),
                ],
              )
            : null,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (MediaQuery.of(context).size.width >= 640)
              NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  leading: const Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.person),
                      ),
                    ],
                  ),
                  destinations: const [
                    NavigationRailDestination(
                        icon: Icon(Icons.home), label: Text("Home")),
                    NavigationRailDestination(
                        icon: Icon(Icons.feed), label: Text("Feed")),
                    NavigationRailDestination(
                        icon: Icon(Icons.favorite), label: Text("Favorites")),
                    NavigationRailDestination(
                        icon: Icon(Icons.settings), label: Text("Settings")),
                  ]),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      "Welcome back! ${widget.api.auth.currentUser!.displayName}",
                      style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ),
          ],
        ));
  }
}
