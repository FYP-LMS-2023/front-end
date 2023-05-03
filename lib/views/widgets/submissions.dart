import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:front_end/constants/fonts.dart';

class Submissions extends StatefulWidget {
  final Function? onClick;
  const Submissions({super.key, this.onClick});

  @override
  State<Submissions> createState() => _SubmissionsState();
}

class _SubmissionsState extends State<Submissions> {
  int numDocs = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < numDocs; i++) doc(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    numDocs++;
                  });
                },
                child: Ink(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                  // color: Colors.grey[400],
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[400],
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 36),
                ),
              ),
              Text("Upload", style: Styles.bodySmall),
            ],
          ),
        ],
      ),
    );
  }

  Row doc(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.02,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {},
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  InkWell(
                    onTap: () => setState(() {
                      numDocs--;
                    }),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.cancel,
                        color: Colors.red[400],
                        size: 20,
                      ),
                    ),
                  ),
                  Ink(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.width * 0.2,
                    // color: Colors.grey[400],
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[400],
                    ),
                    child: const Icon(Icons.picture_as_pdf,
                        color: Colors.white, size: 36),
                  ),
                ],
              ),
            ),
            Text(
              "doc.pdf",
              style: Styles.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
