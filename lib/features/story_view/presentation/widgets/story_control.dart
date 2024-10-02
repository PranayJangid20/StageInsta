import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_insta/features/home/domain/Entity/user_story.dart';
import 'package:stage_insta/features/story_view/presentation/provider/carousel_controller.dart';
import 'package:stage_insta/utils/helper_extensions.dart';
import 'package:stage_insta/utils/ui_helper.dart';

class StoryControl extends StatefulWidget {
  const StoryControl({super.key, required this.user});
  final UserStory user;

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

      int noOfStories = widget.user.stories!.length;

      int target =
          (value.ongoingUser.userName == widget.user.userName ? value.storyIndex : widget.user.watched) ?? 0;

      double perWidth = (size.width - (16 + (10 * (noOfStories - 1)))) / noOfStories;
      print("perWidth $perWidth");

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
                    child: LinearProgressIndicator(
                      value: i < target ? 1.0 :i> target? 0.0:0.5,
                    )),
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
