import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';

class ThreadPage extends StatefulWidget {
  const ThreadPage({super.key});

  @override
  State<ThreadPage> createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  bool isCommentBoxVisible = false;

  void _toggleCommentBox() {
  setState(() {
    isCommentBoxVisible = !isCommentBoxVisible;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thread Title'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User avatar, fullname, and timeSince posted
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 22,
                  child: Text('FL'),
                ),
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full Name',
                      style: Styles.titleMedium
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '2 hours ago',
                      style: Styles.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thread Description dsjfaskdhas ddaskjdoaskd sd asudos dsdjasod s dos ds nsifhaslj faisfjbasfl hasfasufj asfb ashfihs vvo ahas',
                      style: Styles.bodyLarge,
                      maxLines: 10,
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_upward),
                          onPressed: () {},
                        ),
                        Text('10',style: Styles.labelLarge,),
                        // IconButton(
                        //   icon: const Icon(Icons.arrow_downward),
                        //   onPressed: () {},
                        // ),
                        // Text('5',style: Styles.labelLarge,),
                        IconButton(
                          icon: const Icon(Icons.comment),
                          onPressed: () {},
                        ),
                        Text('3',style: Styles.labelLarge,),
                        IconButton(
                          icon: const Icon(Icons.flag),
                          onPressed: () {},
                        ),
                        Text('Exam',style: Styles.labelLarge,),
                      ],
                    ),
                    // const SizedBox(height: 16.0),
                    const Divider(),
                    
                  ]
                )
          ),
          Row(
                      children: [
                        Text(
                          'Comments',
                          style: Styles.titleSmall
                        ),
                        const Icon(Icons.arrow_drop_down_outlined)
                      ],
                    ),
                    const Divider(),
          // Thread description, vote buttons, comments, and flag
Expanded(
  child: SingleChildScrollView(
  child: ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 10,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  child: Text('FL'),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Full Name',
                        style: Styles.labelLarge
                      ),
                      const SizedBox(height: 4.0),
                      const Text(
                        'Comment text goes here dajdhiasd sdhiasjd asd ahsidj asfhasifj asf 93e3 94adha f fuad fyadf dbfuad fadgf adfg afhia fa faodf adbf923 efbafy',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.reply,size: 20,),
                            onPressed: () {},
                          ),
                          Text("Reply", style: Styles.labelMedium,),
                          // const Text('5'),
                          IconButton(
                            icon: const Icon(Icons.arrow_upward, size: 20,),
                            onPressed: () {},
                          ),
                          Text("10", style: Styles.labelMedium,),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left:45.0, top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              child: Text('FL'),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Full Name',
                                    style: Styles.labelLarge
                                  ),
                                  const SizedBox(height: 4.0),
                                  const Text(
                                    'Reply text goes here dajdhiasd sdhiasjd asd ahsidj asfhasifj asf 93e3 94adha f fuad fyadf dbfuad fadgf adfg afhia fa faodf adbf923 efbafy',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.reply,size: 20,),
                                        onPressed: () {},
                                      ),
                                      Text("Reply", style: Styles.labelMedium,),
                                      IconButton(
                                        icon: const Icon(Icons.arrow_upward, size: 20,),
                                        onPressed: () {},
                                      ),
                                      Text("10", style: Styles.labelMedium,),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  );
                }
              )
          ]
        )
      );
    }
  )
  )
),
          // At the bottom of the body Column
        GestureDetector(
          child: Expanded(
            child: Container(
              height:50,
              width: 900,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("Write a comment...", style: Styles.bodyMedium,)
              )
            )
          ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Container(
                      height: 200.0,
                      color: Colors.white,
                      child: Column(
                        children: [
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                maxLines: null,
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  hintText: 'Write a comment...',
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('CANCEL'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('POST'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            )
        ],
        ),
    );
}
}
