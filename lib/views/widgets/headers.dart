import 'package:flutter/material.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/fonts.dart';
import 'dart:math' as math;

import 'package:front_end/views/screens/profile_page.dart';

class ProfileHeader extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String id;

  const ProfileHeader({super.key, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      // backgroundColor: Colors.green,
      centerTitle: false,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.red,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: Styles.name.copyWith(color: Colors.black)),
          Text(id, style: Styles.titleMedium.copyWith(color: Colors.black)),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ));
            },
            child: CircleAvatar(
              backgroundColor: Palette.kToDark[50],
              child: Text(
                name.isNotEmpty ? name[0] : '',
                style: Styles.titleMedium.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

//* Changes need to be made to this
//TODO implement side bar functionality
class CourseHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onMenuPressed;
  // final Widget drawer;
  final String? subtitle;
  final bool disableBack;

  const CourseHeader({
    super.key,
    required this.title,
    required this.onMenuPressed,
    this.subtitle,
    this.disableBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      automaticallyImplyLeading: disableBack ? false : true,
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      leading: disableBack
          ? null
          : IconButton(
              color: Colors.black,
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.name.copyWith(
              color: Colors.black,
            ),
          ),
          subtitle != null
              ? Text(
                  subtitle!,
                  style: Styles.titleMedium.copyWith(
                    color: Colors.black,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
