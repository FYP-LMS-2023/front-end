import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/resource_controller.dart';
import 'package:front_end/models/resource_model.dart';
import 'package:front_end/utils/functions/create_file_icon.dart';
import 'package:front_end/utils/functions/url_launcher.dart';
import 'package:front_end/views/screens/faculty/resources/faculty_edit_resource.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FacResourcePage extends StatefulWidget {
  final ResourceModel? resourceData;
  final String classID;
  const FacResourcePage(
      {super.key, required this.resourceData, required this.classID});

  @override
  State<FacResourcePage> createState() => _FacResourcePageState();
}

class _FacResourcePageState extends State<FacResourcePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CourseHeader(
        title: "Resources",
        onMenuPressed: () {},
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FacEditResourcePage(
                    resource: widget.resourceData!, id: widget.classID),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: boxDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.resourceData!.title,
                        style: Styles.titleMedium,
                        overflow: TextOverflow.clip,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Text(
                        widget.resourceData!.description,
                        style: Styles.bodyMedium,
                        overflow: TextOverflow.clip,
                      ),
                      const VerticalSpacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Posted By: ",
                            style: Styles.titleSmall,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              widget.resourceData!.uploadedBy!.fullName,
                              style: Styles.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Date Posted: ",
                            style: Styles.titleSmall,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              DateFormat('dd MMM yyy @ hh:mm a').format(widget
                                  .resourceData!.dateUploaded as DateTime),
                              style: Styles.bodyMedium,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const VerticalSpacer(),
              const Subheading(text: "Files"),
              ListView.separated(
                shrinkWrap: true,
                itemCount: widget.resourceData!.files.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      launchInBrowser(
                          Uri.parse(widget.resourceData!.files[index].url));
                    },
                    child: Ink(
                      decoration: boxDecoration,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.13,
                              height: MediaQuery.of(context).size.width * 0.13,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: createFileIcon(widget
                                  .resourceData!.files[index].url
                                  .split("-")
                                  .last
                                  .split(".")
                                  .last),
                            ),
                            const HorizontalSpacer(),
                            Expanded(
                              child: Container(
                                child: Text(
                                  widget.resourceData!.files[index].url
                                      .split("/")
                                      .last
                                      .split("-")
                                      .last
                                      .replaceAll('%20', ' '),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
