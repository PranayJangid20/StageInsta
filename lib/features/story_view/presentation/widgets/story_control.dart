import 'package:flutter/material.dart';
import 'package:stage_insta/utils/helper_extensions.dart';
import 'package:stage_insta/utils/ui_helper.dart';

class StoryControl extends StatefulWidget {
  const StoryControl({super.key});

  @override
  State<StoryControl> createState() => _StoryControlState();
}

class _StoryControlState extends State<StoryControl> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    int noOfStories = 4;

    double perWidth = (size.width - (16 + (10 * (noOfStories - 1)))) / noOfStories;
    print("perWidth $perWidth");
    return Column(
      children: [
        //No. of progress bar == No. of stories
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
            height: 2,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, i) => 10.spaceX,
              itemBuilder: (_, i) => SizedBox(width: perWidth, child: LinearProgressIndicator(value: 0.6,)),
              itemCount: noOfStories,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1506863530036-1efeddceb993?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHBvcnRyYWl0fGVufDB8fDB8fHww",
                ),
                radius: 20,
              ),
              16.spaceX,
              Text(
                "UserName",
                style: fsHeadLine5(fontWeight: FontWeight.w500, color: Colors.white),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {},
              )
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Message",
                      hintStyle: fsHeadLine7(fontWeight: FontWeight.w500, color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 14)),
                ),
              ),
              16.spaceX,
              IconButton(onPressed: () {}, icon: Icon(Icons.send_outlined, color: Colors.white,))
            ],
          ),
        )
      ],
    );
  }
}
