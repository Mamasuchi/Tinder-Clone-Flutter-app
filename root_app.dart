import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tindaar/explore_page.dart';
import 'package:tindaar/likes_pages.dart';

import 'explore_page.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [ExplorePage(), LikesPages(), ExplorePage(), ExplorePage()],
    );
  }

  AppBar getAppBar() {
    var items = [
      pageIndex == 0 ? "images/tinder.svg" : "images/icon1.svg",
      pageIndex == 1 ? "images/iconstar.svg" : "images/icon2.svg",
      pageIndex == 2 ? "images/iconmessage.svg" : "images/icon3.svg",
      pageIndex == 3 ? "images/redprofile.svg" : "images/icon4.svg"
    ];
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            return IconButton(
              onPressed: () {
                setState(() {
                  pageIndex = index;
                });
              },
              icon: SvgPicture.asset(
                items[index],
              ),
            );
          }),
        ),
      ),
    );
  }
}
