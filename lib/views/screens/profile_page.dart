import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:front_end/controllers/user_controller.dart';
import 'package:provider/provider.dart';

import '../../constants/fonts.dart';
import '../../constants/log.dart';
import '../../constants/spacers.dart';
import '../../models/user_model.dart';
import '../widgets/headers.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  UserModel? user;

  @override
  Widget build(BuildContext context) {
    user = context.read<UserController>().getUser;
    return Scaffold(
        appBar: const ProfilePageHeader(
          title: "Profile",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Center(
                  child: Column(
                    children: [
                CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.primaries[user != null
                        ? user!.fullName[0].hashCode % Colors.primaries.length
                        : 0],
                    child: Text(
                        user != null
                            ? user!.fullName
                                .split(' ')
                                .map((name) => name[0])
                                .join()
                            : "FL",
                        style: Styles.labelLarge.copyWith(color: Colors.white)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(user != null ? user!.fullName : "Full Name",
                      style: Styles.titleLarge),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(user != null ? user!.erp : "Full Name",
                      style: Styles.titleLarge),
                    ],
                  ),
                ),
                const VerticalSpacer(),
                Card(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        Text("Program", style: Styles.titleMedium,),
                        Text(
                          user != null ? user!.program!.name : "Program", 
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),  
                        const SizedBox(height: 10,),
                        Text("CGPA", style: Styles.titleMedium,),
                        Text(
                          user != null ? user!.cgpa.toString() : "-1", 
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),  
                        const SizedBox(height: 10,),
                        Text("Phone Number", style: Styles.titleMedium,),
                        Text(
                          user != null ? user!.phoneNumber.toString() : "-1", 
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 10,),  
                        Text("Email", style: Styles.titleMedium,),
                        Text(
                          user != null ? user!.email : "-1", 
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                    )
                )
              )
              ],
            ),
          ),
        ));
  }
}
