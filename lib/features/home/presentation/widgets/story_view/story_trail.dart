import 'package:flutter/material.dart';
import 'package:stage_insta/features/home/presentation/widgets/story_widget/story_component.dart';

class StoryTrail extends StatefulWidget {
  const StoryTrail({super.key});

  @override
  State<StoryTrail> createState() => _StoryTrailState();
}

class _StoryTrailState extends State<StoryTrail> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        // shrinkWrap: true,
        padding: EdgeInsets.only(left: 20),
        itemCount: 8,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_,i)=>StoryComponent(),
      ),
    );
  }
}
