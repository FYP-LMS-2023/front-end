import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';

class CourseCard extends StatelessWidget {
  final String courseName;
  final double percentageCompleted;
  const CourseCard(
      {super.key, required this.courseName, required this.percentageCompleted});
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
            Text(courseName, style: Styles.title_medium),
            const SizedBox(
              width: 10.0,
            ),
            Stack(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    value: percentageCompleted / 100,
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Text(
                      '${percentageCompleted.toStringAsFixed(0)}%',
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ToDoCard extends StatefulWidget {
  final String title;
  final String courseName;
  final String dueDay;
  final String dueDate;

  const ToDoCard({
    super.key,
    required this.title,
    required this.courseName,
    required this.dueDay,
    required this.dueDate,
  });

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
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
                Checkbox(
                  value: checkBoxValue,
                  onChanged: (value) => {
                    setState(() {
                      checkBoxValue = !checkBoxValue;
                    })
                  },
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.title, style: Styles.title_medium),
                    const SizedBox(height: 5),
                    Text(widget.courseName, style: Styles.body_medium),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Due:',
                  textAlign: TextAlign.right,
                  style: Styles.body_small.copyWith(color: Colors.grey),
                ),
                Text(
                  widget.dueDay,
                  textAlign: TextAlign.right,
                  style: Styles.body_small.copyWith(color: Colors.grey),
                ),
                Text(
                  widget.dueDate,
                  textAlign: TextAlign.right,
                  style: Styles.body_small.copyWith(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class FeedbackCard extends StatelessWidget {
  final String title;
  final String courseName;
  final String dayPosted;
  final String datePosted;

  const FeedbackCard(
      {super.key,
      required this.title,
      required this.courseName,
      required this.dayPosted,
      required this.datePosted});

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: Styles.title_medium),
                    const SizedBox(height: 5),
                    Text(courseName, style: Styles.body_medium),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Due:',
                  textAlign: TextAlign.right,
                  style: Styles.body_small.copyWith(color: Colors.grey),
                ),
                Text(
                  dayPosted,
                  textAlign: TextAlign.right,
                  style: Styles.body_small.copyWith(color: Colors.grey),
                ),
                Text(
                  datePosted,
                  textAlign: TextAlign.right,
                  style: Styles.body_small.copyWith(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
