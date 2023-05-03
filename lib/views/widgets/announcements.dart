import 'package:flutter/material.dart';
import 'package:front_end/constants/spacers.dart';

class Announcements extends StatelessWidget {
  const Announcements({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.height / 5) * 0.35,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Row(
          children: [
            InkWell(
              onTap: () {},
              child: CircleAvatar(
                radius: (MediaQuery.of(context).size.width / 5) * 0.35,
                backgroundColor: Colors.grey[400],
                child: const Icon(
                  Icons.assignment,
                  color: Colors.white,
                ),
              ),
            ),
            //jugaar
            if (index != 4) const HorizontalSpacer(),
          ],
        ),
      ),
    );
  }
}
