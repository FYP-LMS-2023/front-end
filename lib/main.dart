import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/utils/widgets/buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MASH LMS',
      theme: ThemeData(primarySwatch: Colors.red)
      home: const MyHomePage(title: 'MASH LMS'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Styles.appbarTitle,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "These font styles will be changed",
                style: Styles.inputLabel,
              ),
              const SizedBox(
                height: 64,
              ),
              Text("Page Header", style: Styles.pageHeader),
              const Text(
                "Banner",
                style: Styles.banners,
              ),
              Text(
                "Input Label",
                style: Styles.inputLabel,
              ),
              Text(
                "Sublabel",
                style: Styles.subLabel,
              ),
              const SizedBox(
                height: 64,
              ),
              MainButton(
                text: "Submit",
                onPressed: () {},
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}
