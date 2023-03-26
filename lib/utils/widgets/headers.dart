import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';

class TestHeader extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String id;

  const TestHeader({super.key, required this.name, required this.id});

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
          style: Styles.title_medium.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: Styles.title_medium.copyWith(color: Colors.black)),
          Text(id, style: Styles.body_medium.copyWith(color: Colors.black)),
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
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
