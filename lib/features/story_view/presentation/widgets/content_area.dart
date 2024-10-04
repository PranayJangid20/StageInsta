import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_insta/features/home/domain/Entity/user_story.dart';
import 'package:stage_insta/features/story_view/presentation/provider/carousel_controller.dart';
import 'package:stage_insta/utils/helper_extensions.dart';
import 'package:stage_insta/utils/ui_helper.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ContentArea extends StatefulWidget {
  const ContentArea({super.key, required this.story, required this.index});

  final UserStory story;
  final int index;

  @override
  State<ContentArea> createState() => _ContentAreaState();
}

class _ContentAreaState extends State<ContentArea> {
  int toWatch = -1;

  @override
  Widget build(BuildContext context) {
    // The code might seen redundant, but it also save data locally for the widget

    if (toWatch == -1) {
      toWatch = widget.story.watched ?? 0;
    }


    // int predictTo = widget.story.stories!.length - (widget.story.watched??0);
    //
    // // "value - $predictTo".log();
    // if(predictTo == 1){
    //   toWatch = 0;
    // }


    return Consumer<StoryController>(builder: (context, value, _) {
      bool isFocused = value.ongoingUser.userName == widget.story.userName;

      if(widget.story.watched == widget.story.stories!.length){
        toWatch = 0;
      }

      // if(widget.index < value.userIndex && predictTo == 1){
      //   toWatch = 0;
      // }

      // it decide if display local or global index
      int target =
          (isFocused ? value.storyIndex : toWatch) ?? 0;

      // "displaying_${target}".log();

      return Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                child: GestureDetector(
                  onTapUp: (point) {
                    Size size = MediaQuery.of(context).size;
                    double pixel = point.globalPosition.dx;

                    if (pixel < size.width * 0.5) {
                        value.previousStory();

                    } else {
                      value.nextStory();
                    }
                  },
                  onLongPress: () {
                    //Hold with timer
                    value.pauseStory();
                  },

                  onLongPressEnd: (l){
                    value.resumeStory();
                  },onLongPressCancel: (){
                    value.resumeStory();
                  },
                  child: SizedBox(
                    child: CachedNetworkImage(
                      imageUrl: widget.story.stories![target.clamp(0, widget.story.stories!.length-1)], // using clamp because toWatch refers to count for another component and here it is picking image
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                      fadeInDuration: Duration(milliseconds: 0),
                      fadeInCurve: Curves.linear,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
            child: Row(
              children: [
                widget.story.commenting == true
                    ? Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Message",
                              hintStyle: fsHeadLine7(fontWeight: FontWeight.w500, color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 14)),
                        ),
                      )
                    : Spacer(),
                16.spaceX,
                widget.story.likable == true?SvgPicture.asset("assets/svg/heart.svg", width: 26,):SizedBox.shrink(),
                8.spaceX,
                InkWell(
                    onTap: () {},
                    child: SvgPicture.asset("assets/svg/send.svg", width: 26,),)
              ],
            ),
          )
        ],
      );
    });
  }
}
