import 'package:flutter/material.dart';

class Announcements extends StatelessWidget {
  const Announcements({super.key});

  @override
  Widget build(BuildContext context) {
    return 
        SizedBox(
          height: 60,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index) => 
              Padding(
                padding: const EdgeInsets.only(right:10.0),
                child: InkWell(
                  onTap: () {},
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.announcement),
                  ),
                ),
              )
           
            ),
        );
  }
}