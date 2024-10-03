import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_insta/features/home/domain/Entity/user_story.dart';
import 'package:stage_insta/features/story_view/presentation/provider/carousel_controller.dart';
import 'package:stage_insta/features/story_view/presentation/widgets/running_bar.dart';
import 'package:stage_insta/utils/helper_extensions.dart';
import 'package:stage_insta/utils/ui_helper.dart';

class StoryControl extends StatefulWidget {
  const StoryControl({super.key, required this.user, required this.index});
  final UserStory user;
  final int index;

  @override
  State<StoryControl> createState() => _StoryControlState();
}

class _StoryControlState extends State<StoryControl> {
  int toWatch = -1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (toWatch == -1) {
      toWatch = widget.user.watched ?? 0;
    }



    return Consumer<StoryController>(builder: (context, value, _) {
      bool isFocused = value.ongoingUser.userName == widget.user.userName;

      if(widget.user.watched == widget.user.stories!.length){
        toWatch = 0;
      }

      int noOfStories = widget.user.stories!.length;


      // if(widget.index < value.userIndex && predictTo == 1){
      //   toWatch = 0;
      // }

      int target = (isFocused ? value.storyIndex : toWatch) ?? 0;

      double perWidth = (size.width - (16 + (10 * (noOfStories - 1)))) / noOfStories;
      // print("perWidth $perWidth");


      return Column(
        children: [
          //No. of progress bar == No. of stories
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: SizedBox(
              height: 2,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, i) => 10.spaceX,
                itemBuilder: (_, i) => SizedBox(
                    width: perWidth,
                    child: i < target
                        ? const LinearProgressIndicator(
                            value: 1.0,
                          )
                        : i > target
                            ? const LinearProgressIndicator(
                                value: 0.0,
                              )
                            : RunningBar()),
                itemCount: noOfStories,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8.0, 2, 0),
            child: Row(
              children: [
                Hero(
                  tag: "profile_pic",
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.user.userImage ?? "",
                    ),
                    radius: 20,
                  ),
                ),
                16.spaceX,
                Text(
                  widget.user.userName ?? "",
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
        ],
      );
    });
  }
}
