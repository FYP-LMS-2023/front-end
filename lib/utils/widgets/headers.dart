import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';

class ProfileHeader extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String id;

  const ProfileHeader({super.key, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      leading: CircleAvatar(
        backgroundColor: Colors.black,
        child: Text(
          name.isNotEmpty ? name[0] : '',
          style: Styles.titleMedium.copyWith(fontWeight: FontWeight.bold),
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


//* Changes need to be made to this
//TODO implement side bar functionality
class CourseHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onMenuPressed;

  const CourseHeader(
      {super.key, required this.title, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      leading: IconButton(
        color: Colors.black,
        icon: const Icon(Icons.menu),
        onPressed: onMenuPressed as void Function()?,
      ),
      title:
          Text(title, style: Styles.titleMedium.copyWith(color: Colors.black)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
