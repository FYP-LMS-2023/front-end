import 'package:flutter/material.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/drop_shadow.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/views/screens/assignment_page.dart';
import 'package:front_end/views/widgets/cards.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:provider/provider.dart';

import '../../constants/log.dart';
import '../../controllers/assignment_controller.dart';
import '../../models/assignment_model.dart';

// class AssignmentListPage extends StatefulWidget {

//   AssignmentListPage(this.id, {super.key});
//   String? id;
//   @override
//   State<AssignmentListPage> createState() => _AssignmentListPageState();
// }

// class _AssignmentListPageState extends State<AssignmentListPage> {
//   List<AssignmentModel>? assignments;

  
//   Future<void> fetchAssignments() async {
//     try {
//       await context.read<AssignmentController>().getAllAssignments(widget.id != null ? widget.id! : "1")
//         .then(
//           (value) {
//             setState(() {
//               assignments = context.read<AssignmentController>().getAssignments;
//               print("Assignments length: ${assignments!.length}");
//             });
//           }
//         );
//     } catch (e) {
//       // Handle the error
//     }
//   }

//   @override
//   void initState() {
//     
//     super.initState();
//     fetchAssignments();
//   }

//   @override
//   Widget build(BuildContext context) {
//   final size = MediaQuery.of(context).size;
//   //fetchAssignments();
//   return Column(
//     children: <Widget>[
//       // buildStats(context),
//       // const VerticalSpacer(),
//       // const Subheading(text: "Assignments"),
//       assignments == null
//           ? Center(
//               child: Container(
//                   height: size.height * 0.05,
//                   alignment: Alignment.center,
//                   child: Text("No assignments yet",
//                       style: Styles.bodySmall.copyWith(
//                           color: Color.fromARGB(255, 97, 65, 65)),
//                       textAlign: TextAlign.center)),
//             )
//           : Expanded(
//             child: ListView.builder(
//               shrinkWrap: true,
//               scrollDirection: Axis.vertical,
//               clipBehavior: Clip.none,
//               itemCount: assignments!.length,
//               itemBuilder: (context, index) {
//                 AssignmentModel assignment = assignments![index];
//                 return Column(
//                   children: [
//                     CourseOverviewCard(
//                       type: "assignment",
//                       title: assignment.title,
//                       date: DateTime.now(),
//                       description: assignment.description,
//                       status: assignment.status,
//                       onClick: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => const AssignmentPage(
//                               graded: false,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.02,
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//     ],
//   );
// }


//   Row buildStats(context) {
//     final size = MediaQuery.of(context).size;
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: (size.width - ((size.width * 0.05) * 4)) / 3,
//           height: (size.width - ((size.width * 0.05) * 4)) / 3,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             color: Palette.kToDark[50],
//             boxShadow: dropShadow,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(height: size.height * 0.01),
//               Text('${20}%',
//                   style: Styles.headlineLarge.copyWith(color: Colors.white)),
//               Text(
//                 "Current",
//                 style: Styles.labelLarge.copyWith(color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(width: size.width * 0.05),
//         Container(
//           width: (size.width - ((size.width * 0.05) * 4)) / 3,
//           height: (size.width - ((size.width * 0.05) * 4)) / 3,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             color: Colors.white,
//             boxShadow: dropShadow,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(height: size.height * 0.01),
//               Text('${40}%', style: Styles.headlineLarge),
//               Text(
//                 "Weightage",
//                 style: Styles.labelLarge,
//               ),
//             ],
//           ),
//         ),
//         SizedBox(width: size.width * 0.05),
//         Container(
//           width: (size.width - ((size.width * 0.05) * 4)) / 3,
//           height: (size.width - ((size.width * 0.05) * 4)) / 3,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               color: Colors.white,
//               boxShadow: dropShadow),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(height: size.height * 0.01),
//               Text('${25}', style: Styles.headlineLarge),
//               Text(
//                 "/${50} Points",
//                 style: Styles.labelLarge,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:math';

class AssignmentListPage extends StatefulWidget {
  AssignmentListPage(this.id, {super.key, this.fullname});
  String? id;
  String? fullname;
  @override
  State<AssignmentListPage> createState() => _AssignmentListPageState();
}

class _AssignmentListPageState extends State<AssignmentListPage> {
  List<AssignmentModel>? assignments;
  
  // final List<String> assignments = [    'Assignment 1',    'Assignment 2',    'Assignment 3',    'Assignment 4',    'Assignment 5',    'Assignment 6',    'Assignment 7',    'Assignment 8',    'Assignment 9',    'Assignment 10' ,  'Assignment 11' ,  'Assignment 12' ,  'Assignment 13' ,  'Assignment 14'   ];

    Future<void> fetchAssignments() async {
    try {
      await context.read<AssignmentController>().getAllAssignments(widget.id != null ? widget.id! : "1")
        .then(
          (value) {
            setState(() {
              assignments = context.read<AssignmentController>().getAssignments;
              print("Assignments length: ${assignments!.length}");
            });
          }
        );
    } catch (e) {
      Log.e("error araha fetch assignments me $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAssignments();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [

            buildStats(context),
            const VerticalSpacer(),
            const Subheading(text: "Assignments"),
            SizedBox(height: size.height * 0.02),
            assignments == null ?
              const Center(child: CircularProgressIndicator(color: Colors.black,))
            :
            assignments!.isEmpty ? 
            Container(
                height: size.height * 0.05,
                alignment: Alignment.center,
                child: Text("No assignments yet",
                    style: Styles.bodySmall.copyWith(
                        color: const Color.fromARGB(255, 97, 65, 65)),
                    textAlign: TextAlign.center))
            :
            Expanded(
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                // clipBehavior: Clip.none,
                itemCount: assignments !=null ? assignments!.length : 0,
                itemBuilder: (context, index) {
                  AssignmentModel assignment = assignments![index];
                  return Column(
                    children: [
                      CourseOverviewCard(
                        type: "assignment",
                        title: assignment.title,
                        date: DateTime.now(),
                        description: assignment.description,
                        status: assignment.status,
                        postedBy: widget.fullname,
                        onClick: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => 
                              AssignmentPage(
                                id: assignment.id,
                                graded: false,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
    );
  }

    Row buildStats(context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: (size.width - ((size.width * 0.05) * 4)) / 3,
          height: (size.width - ((size.width * 0.05) * 4)) / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Palette.kToDark[50],
            boxShadow: dropShadow,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.01),
              Text('${20}%',
                  style: Styles.headlineLarge.copyWith(color: Colors.white)),
              Text(
                "Current",
                style: Styles.labelLarge.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(width: size.width * 0.05),
        Container(
          width: (size.width - ((size.width * 0.05) * 4)) / 3,
          height: (size.width - ((size.width * 0.05) * 4)) / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: dropShadow,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.01),
              Text('${40}%', style: Styles.headlineLarge),
              Text(
                "Weightage",
                style: Styles.labelLarge,
              ),
            ],
          ),
        ),
        SizedBox(width: size.width * 0.05),
        Container(
          width: (size.width - ((size.width * 0.05) * 4)) / 3,
          height: (size.width - ((size.width * 0.05) * 4)) / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: dropShadow),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.01),
              Text('${25}', style: Styles.headlineLarge),
              Text(
                "/${50} Points",
                style: Styles.labelLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
