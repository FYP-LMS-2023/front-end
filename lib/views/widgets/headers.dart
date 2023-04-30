import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';

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
      centerTitle: false,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: CircleAvatar(
          backgroundColor: Colors.black,
          child: Text(
            name.isNotEmpty ? name[0] : '',
            style: Styles.titleMedium.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: Styles.titleMedium.copyWith(color: Colors.black)),
          Text(id, style: Styles.bodyMedium.copyWith(color: Colors.black)),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          color: Colors.black,
          onPressed: () {
            // TODO: add action
          },
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
      automaticallyImplyLeading: disableBack ? false : true,
      iconTheme: IconThemeData(color: Colors.black),
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
            style: Styles.titleMedium.copyWith(
              color: Colors.black,
            ),
          ),
          subtitle != null
              ? Text(
                  subtitle!,
                  style: Styles.labelMedium.copyWith(
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
