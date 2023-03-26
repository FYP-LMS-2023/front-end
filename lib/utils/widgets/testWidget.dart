import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';

class CustomCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget leading;
  final Widget trailing;

  const CustomCard({
    super.key,
    required this.title,
    this.subtitle = "",
    this.leading = const SizedBox(),
    this.trailing =  const SizedBox(),
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: const BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                if (widget.leading != const SizedBox()) widget.leading,
                if (widget.leading != const SizedBox())
                  const SizedBox(
                    width: 10,
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.title, style: Styles.title_medium),
                    if (widget.subtitle != "")
                      const SizedBox(
                        height: 5,
                      ),
                    if (widget.subtitle != "")
                      Text(widget.subtitle, style: Styles.body_medium),
                  ],
                ),
              ],
            ),
            if (widget.trailing != const SizedBox()) widget.trailing,
          ],
        ),
      ),
    );
  }
}
