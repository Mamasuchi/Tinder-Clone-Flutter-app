import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tindaar/user.dart';
import 'package:provider/provider.dart';
import 'package:tindaar/user_card_widget.dart';
import 'package:tindaar/users.dart';
import 'feedback_position_provider.dart';

enum SwipingDirection { left, right, none }

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<User> users = dummyUsers;

  int next = 0;
  bool isUserInFocus = true;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            users.isEmpty
                ? Text('No more users')
                : Stack(children: users.map(buildUser).toList()),
            Expanded(child: Container()),
          ],
        ),
      ),
      bottomSheet: getFooter(),
    );
  }

  Widget getFooter() {
    var size = MediaQuery.of(context).size;
    const List item_icons = [
      {"icon": "images/refreshicon1.svg", "size": 45.0, "icon_size": 40.0},
      {"icon": "images/exiticon.svg", "size": 58.0, "icon_size": 58.0},
      {"icon": "images/staricon.svg", "size": 45.0, "icon_size": 40.0},
      {"icon": "images/hearticon.svg", "size": 57.0, "icon_size": 57.0},
      {"icon": "images/thundericon.svg", "size": 45.0, "icon_size": 40.0}
    ];

    return Container(
      width: size.width,
      height: 108,
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(item_icons.length, (index) {
            //generates list of icons from var item_icon
            return Container(
              width: item_icons[index]['size'],
              height: item_icons[index]['size'],
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 10)
                  ]),
              child: Center(
                child: SvgPicture.asset(
                  item_icons[index]['icon'],
                  width: item_icons[index]['icon_size'],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget buildUser(User user) {
    final userIndex = users.indexOf(user);
    final isUserInFocus = userIndex == users.length - 1;

    return Listener(
      onPointerMove: (pointerEvent) {
        final provider =
            Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.updatePosition(pointerEvent.localDelta.dx);
      },
      onPointerCancel: (_) {
        final provider =
            Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.resetPosition();
      },
      onPointerUp: (_) {
        final provider =
            Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.resetPosition();
      },
      child: Draggable(
        child: UserCardWidget(
          user: user,
          isUserInFocus: isUserInFocus,
          slider: next,
        ),
        feedback: Material(
          type: MaterialType.transparency,
          child: UserCardWidget(
            user: user,
            isUserInFocus: isUserInFocus,
            slider: next,
          ),
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) => onDragEnd(details, user),
      ),
    );
  }

  void onDragEnd(DraggableDetails details, User user) {
    final minimumDrag = 100;
    if (details.offset.dx > minimumDrag) {
      next++;
      user.isSwipedOff = true;
    } else if (details.offset.dx < -minimumDrag) {
      next++;
      user.isLiked = true;
    }

    setState(() => users.remove(user));
  }
}
