import 'package:flutter/material.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/controllers/class_controller.dart';
import 'package:front_end/models/class_model.dart';
import 'package:front_end/models/resource_model.dart';
import 'package:front_end/controllers/resource_controller.dart';
import 'package:provider/provider.dart';

class ResourceListPage extends StatefulWidget {
  String? id;

  ResourceListPage({Key? key, this.id}) : super(key: key);

  @override
  _ResourceListPageState createState() => _ResourceListPageState();
}

class _ResourceListPageState extends State<ResourceListPage> {
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
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: resources != null
            ? classData!.resources.length
            : 0, //resources != null ? classData!.resources.length :
        itemBuilder: (context, index) {
          //final resource = widget.classData!.resources;
          return ListTile(
            title: Text("No File Found"), //resources != null ? resources![index].fileName
            subtitle: Text(resources != null
                ? resources![index].dateUploaded.toString()
                : "No File Found"),
            trailing: IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {
                // Add functionality to download resource here
              },
            ),
          );
        },
      ),
    );
  }
}
