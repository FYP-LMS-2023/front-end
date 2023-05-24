import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/class_controller.dart';
import 'package:front_end/controllers/resource_controller.dart';
import 'package:front_end/models/class_model.dart';
import 'package:front_end/models/resource_model.dart';
import 'package:front_end/views/screens/faculty/resources/faculty_add_resource.dart';
import 'package:front_end/views/screens/faculty/resources/faculty_resource_page.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FacResourceListPage extends StatefulWidget {
  final String? id;
  const FacResourceListPage({super.key, this.id});

  @override
  State<FacResourceListPage> createState() => _FacResourceListPageState();
}

class _FacResourceListPageState extends State<FacResourceListPage> {
  bool loading = true;
  List<ResourceModel>? resources;
  ClassModel? classData;

  Future<void> fetchResources() async {
    try {
      await context
          .read<ResourceController>()
          .getAllResources(widget.id != null ? widget.id! : "1")
          .then((value) {
        setState(() {
          loading = false;
          resources = context.read<ResourceController>().getResources;
          classData = context.read<ClassController>().getMyClass;
        });
      });
    } catch (e) {
      Log.e("$e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchResources();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : SingleChildScrollView(
            child: Center(
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Column(
                  children: [
                    const Subheading(text: "Resources"),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return FacAddResourcePage(
                                classID: widget.id != null ? widget.id! : "1",
                              );
                            },
                          ),
                        );
                      },
                      child: Ink(
                        padding: const EdgeInsets.all(4.0),
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            Text(
                              "Add Resource",
                              style: Styles.titleMedium
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const VerticalSpacer(),
                    resources == null || resources!.isEmpty
                        ? Container(
                            height: size.height * 0.5,
                            child: Text(
                              "No assignments yet",
                              style: Styles.bodySmall.copyWith(
                                color: Color.fromARGB(255, 97, 65, 65),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: resources != null
                                ? resources!.length
                                : 0, //resources != null ? classData!.resources.length :
                            itemBuilder: (context, index) {
                              //final resource = widget.classData!.resources;
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => FacResourcePage(
                                      resourceData: resources != null
                                          ? resources![index]
                                          : null,
                                      classID:
                                          widget.id != null ? widget.id! : "1",
                                    ),
                                  ));
                                },
                                child: Ink(
                                  padding: const EdgeInsets.all(16),
                                  decoration: boxDecoration,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                resources != null
                                                    ? resources![index].title
                                                    : "File Not Found",
                                                overflow: TextOverflow.clip,
                                                style: Styles.titleSmall,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                resources != null
                                                    ? resources![index]
                                                        .description
                                                    : "No File Found",
                                                style:
                                                    Styles.bodySmall.copyWith(
                                                  color: Colors.grey,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Spacer(flex: ),
                                      Container(
                                        child: Text(
                                          resources != null
                                              ? DateFormat('dd MMM, yyy')
                                                  .format(resources![index]
                                                      .dateUploaded!)
                                                  .toString()
                                              : "No File Found",
                                          style: Styles.bodySmall.copyWith(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
          );
  }
}
