import 'package:flutter/material.dart';
import 'package:stage_insta/features/home/presentation/cubit/user_story_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stage_insta/features/home/presentation/widgets/story_widget/story_component.dart';
import 'package:stage_insta/features/home/presentation/widgets/story_widget/story_component_placeholder.dart';

class StoryTrail extends StatefulWidget {
  const StoryTrail({super.key});

  @override
  State<StoryTrail> createState() => _StoryTrailState();
}

class _StoryTrailState extends State<StoryTrail> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: BlocBuilder<UserStoryCubit, UserStoryState>(
        builder: (context, state) {
          return state is UserStoryLoaded? ListView.builder(
            // shrinkWrap: true,
            padding: EdgeInsets.only(left: 20),
            itemCount: state.stories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) => StoryComponent(story: state.stories[i],),
          ): ListView.builder(
            // shrinkWrap: true,
            padding: EdgeInsets.only(left: 20),
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) => StoryComponentPlaceholder(),
          );
        },
      ),
    );
  }
}
