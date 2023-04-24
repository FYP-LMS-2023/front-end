part of 'custom_widgets.dart';

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
            Text(courseName, style: Styles.titleMedium),
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
                    Text(widget.title, style: Styles.titleMedium),
                    const SizedBox(height: 5),
                    Text(widget.courseName, style: Styles.bodyMedium),
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
                  style: Styles.bodySmall.copyWith(color: Colors.grey),
                ),
                Text(
                  widget.dueDay,
                  textAlign: TextAlign.right,
                  style: Styles.bodySmall.copyWith(color: Colors.grey),
                ),
                Text(
                  widget.dueDate,
                  textAlign: TextAlign.right,
                  style: Styles.bodySmall.copyWith(color: Colors.grey),
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
                    Text(title, style: Styles.titleMedium),
                    const SizedBox(height: 5),
                    Text(courseName, style: Styles.bodyMedium),
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
                  style: Styles.bodySmall.copyWith(color: Colors.grey),
                ),
                Text(
                  dayPosted,
                  textAlign: TextAlign.right,
                  style: Styles.bodySmall.copyWith(color: Colors.grey),
                ),
                Text(
                  datePosted,
                  textAlign: TextAlign.right,
                  style: Styles.bodySmall.copyWith(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}



//! THIS IS CURRENTLY UNDER DEVELOPMENT
//TODO - refactor the functionality of this card
class NumberOfStudentsCard extends StatelessWidget {
  final int numberOfStudents;

  const NumberOfStudentsCard({super.key, required this.numberOfStudents});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.33,
      // width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            numberOfStudents.toString(),
            style: Styles.titleMedium.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Students',
            style: Styles.bodyMedium.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

//! THIS IS CURRENTLY UNDER DEVELOPMENT
//TODO - refactor the functionality of this card
class ThreeLineCard extends StatelessWidget {
  final String title;
  final String subtitle1;
  final String subtitle2;

  const ThreeLineCard({
    super.key,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.5,
      // width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: Styles.labelLarge,
          ),
          Text(
            subtitle1,
            textAlign: TextAlign.left,
            style: Styles.bodySmall,
          ),
        ],
      ),
    );
  }
}
