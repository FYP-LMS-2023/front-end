import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/controllers/class_controller.dart';
import 'package:front_end/models/class_model.dart';
import 'package:front_end/models/resource_model.dart';
import 'package:front_end/controllers/resource_controller.dart';
import 'package:front_end/views/screens/resource_page.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ResourceListPage extends StatefulWidget {
  String? id;

  ResourceListPage({Key? key, this.id}) : super(key: key);

  @override
  _ResourceListPageState createState() => _ResourceListPageState();
}

class _ResourceListPageState extends State<ResourceListPage> {
  bool loading = true;
  List<ResourceModel>? resources;
  ClassModel? classData;

  Future<void> fetchResourceDetails() async {
    Log.i("fetching resources details");
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

      // Log.d("resource details: ${resources![0].fileName}");
    } catch (e) {
      Log.e("$e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchResourceDetails();
  }

  @override
  Widget build(BuildContext context) {
    Log.i("building resource list page, resources: $resources");
    return loading
        ? Loading()
        : SingleChildScrollView(
            child: Center(
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: resources != null
                      ? resources!.length
                      : 0, //resources != null ? classData!.resources.length :
                  itemBuilder: (context, index) {
                    //final resource = widget.classData!.resources;
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResourcePage(
                            resourceData:
                                resources != null ? resources![index] : null,
                            classData:
                                '${classData?.course?.courseCode} - ${classData?.course?.courseName}',
                          ),
                        ));
                      },
                      child: Ink(
                        padding: const EdgeInsets.all(16),
                        decoration: boxDecoration,
                        child: Row(
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          ? resources![index].description
                                          : "No File Found",
                                      style: Styles.bodySmall.copyWith(
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
                                        .format(resources![index].dateUploaded!)
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
              ),
            ),
          );
  }
}
