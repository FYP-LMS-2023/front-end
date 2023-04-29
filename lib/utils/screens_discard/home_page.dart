// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:front_end/entities/class_entity.dart';
// import 'package:front_end/controllers/class_controller.dart';
// import 'package:front_end/utils/screens/course/course_main_page.dart';
// import 'package:front_end/utils/widgets/cards.dart';
// import 'package:front_end/utils/widgets/headers.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<ClassEntity> list = [];
//   @override
//   Widget build(BuildContext context) {
//     list = context.watch<ClassProvider>().getClasses;
//     return Scaffold(
//       appBar: const ProfileHeader(
//         name: "Shaheer Ahmed",
//         id: "18635",
//       ),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         child: ListView.builder(
//           scrollDirection: Axis.vertical,
//           clipBehavior: Clip.none,
//           itemCount: list.length,
//           itemBuilder: (context, index) {
//             return HomeOverviewCard(
//               title: list[index].courseName,
//               trailing: CourseProgress(progress: Random().nextDouble() * 100),
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => CourseMainPage(
//                       myclass: list[index],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//     // body: Center(
//     //   child: Column(
//     //     mainAxisAlignment: MainAxisAlignment.center,
//     //     children: [
//     //       const Text("Home Page"),
//     //       MainButton(
//     //         text: myclass.courseName,
//     //         onPressed: () {
//     //           Navigator.of(context).push(
//     //             MaterialPageRoute(
//     //               builder: (context) => CourseMainPage(
//     //                 myclass: myclass,
//     //               ),
//     //             ),
//     //           );
//     //         },
//     //       )
//     //     ],
//     //   ),
//     // ),
//     // return Scaffold(
//     //   drawer: Drawer(),
//     //   appBar: AppBar(
//     //     title: const Text("Home Page"),
//     //   ),
//     // );
//   }
// }
