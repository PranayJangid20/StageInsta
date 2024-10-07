import 'package:flutter/cupertino.dart';
import 'package:stage_insta/features/home/domain/Entity/user_story.dart';
import 'package:stage_insta/features/story_view/presentation/widgets/content_area.dart';
import 'package:stage_insta/features/story_view/presentation/widgets/story_overlay.dart';

class StoryGround extends StatefulWidget {
  const StoryGround({super.key, required this.story, required this.index});

  final UserStory story;
  final int index;

  @override
  State<StoryGround> createState() => _StoryGroundState();
}

class _StoryGroundState extends State<StoryGround> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment:Alignment.center,
      children: [

        ContentArea(user: widget.story, index : widget.index),

        StoryOverlay(user: widget.story, index : widget.index)
      ],
    );
  }
}
