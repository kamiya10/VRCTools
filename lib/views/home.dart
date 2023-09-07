import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vrchat_dart/vrchat_dart.dart';
import 'package:vrctools/views/user.dart';

class HomeView extends StatefulWidget {
  final VrchatDart api;
  const HomeView(this.api, {super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  Future<CachedNetworkImageProvider> getImage(String url) async {
    return widget.api.rawApi.dio.get(url).then((res) {
      return CachedNetworkImageProvider(res.redirects.last.location.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("VRCTools"),
          actions: [
            FutureBuilder<CachedNetworkImageProvider>(
              future: getImage(
                  widget.api.auth.currentUser!.currentAvatarThumbnailImageUrl),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        child: CircleAvatar(backgroundImage: snapshot.data),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UserView(
                                  widget.api, widget.api.auth.currentUser)));
                        },
                      ));
                } else {
                  return const Padding(
                      padding: EdgeInsets.all(8),
                      child: CircleAvatar(child: Icon(Icons.person)));
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
