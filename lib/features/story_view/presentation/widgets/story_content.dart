import 'package:flutter/cupertino.dart';
import 'package:stage_insta/features/home/domain/Entity/user_story.dart';
import 'package:stage_insta/features/story_view/presentation/widgets/content_area.dart';
import 'package:stage_insta/features/story_view/presentation/widgets/story_control.dart';

class StoryContent extends StatefulWidget {
  const StoryContent({super.key, required this.story, required this.index});

  final UserStory story;
  final int index;

  @override
  State<StoryContent> createState() => _StoryContentState();
}

class _StoryContentState extends State<StoryContent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment:Alignment.center,
      children: [

        ContentArea(story: widget.story, index : widget.index),

        StoryControl(user: widget.story, index : widget.index)
      ],
    );
  }
}
