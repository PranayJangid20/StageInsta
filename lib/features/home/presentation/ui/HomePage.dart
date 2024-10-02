import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stage_insta/common/app_colors.dart';
import 'package:stage_insta/features/home/presentation/cubit/user_story_cubit.dart';
import 'package:stage_insta/features/home/presentation/widgets/story_view/story_trail.dart';
import 'package:stage_insta/utils/ui_helper.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  void initState() {
    // TODO: implement initState

    context.read<UserStoryCubit>().getUserStories();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const SliverAppBar(
          pinned: false,
          snap: false,
          floating: true,
          toolbarHeight: 68,
          title: Text(
            "Instagram",
            style: TextStyle(
                color: AppColors.blackShade1, fontWeight: FontWeight.w500, fontSize: 26, fontFamily: "Freehand"),
          ),
        ),
        SliverToBoxAdapter(
          child: StoryTrail(),
        )
      ],
    ));
  }
}
