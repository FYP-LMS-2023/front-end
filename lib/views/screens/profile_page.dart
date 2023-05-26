import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/controllers/user_controller.dart';
import 'package:provider/provider.dart';

import '../../constants/fonts.dart';
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
        backgroundColor: backgroundColor,
        appBar: const ProfilePageHeader(
          title: "Profile",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                VerticalSpacer(),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.primaries[user != null
                            ? user!.fullName[0].hashCode %
                                Colors.primaries.length
                            : 0],
                        child: Text(
                            user != null
                                ? user!.fullName
                                    .split(' ')
                                    .map((name) => name[0])
                                    .join()
                                : "FL",
                            style: Styles.headlineSmall
                                .copyWith(color: Colors.white)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(user != null ? user!.fullName : "Full Name",
                          style: Styles.headlineSmall),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(user != null ? user!.erp : "Full Name",
                          style: Styles.headlineSmall),
                    ],
                  ),
                ),
                const VerticalSpacer(),
                Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: boxDecoration,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Program",
                            style: Styles.titleMedium,
                          ),
                          Text(
                            user != null ? user!.program!.name : "Program",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600]),
                          ),
                          const VerticalSpacer(),
                          user!.userType == "Faculty"
                              ? const SizedBox()
                              : Text(
                                  "CGPA",
                                  style: Styles.titleMedium,
                                ),
                          user!.userType == "Faculty"
                              ? const SizedBox()
                              : Text(
                                  user != null ? user!.cgpa.toString() : "-1",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[600]),
                                ),
                          const VerticalSpacer(),
                          Text(
                            "Phone Number",
                            style: Styles.titleMedium,
                          ),
                          Text(
                            user != null ? user!.phoneNumber.toString() : "-1",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600]),
                          ),
                          const VerticalSpacer(),
                          Text(
                            "Email",
                            style: Styles.titleMedium,
                          ),
                          Text(
                            user != null ? user!.email : "-1",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
