import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:stage_insta/features/home/domain/Entity/user_story.dart';
import 'package:stage_insta/features/home/presentation/cubit/user_story_cubit.dart';
import 'package:stage_insta/features/story_view/presentation/provider/carousel_controller.dart';
import 'package:stage_insta/features/story_view/presentation/widgets/story_content.dart';
import 'package:stage_insta/utils/helper_extensions.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key, required this.userName});
  final String userName;

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {

  int initialPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    initialPage = context.read<StoryController>().setStories(context.read<UserStoryCubit>().stories, widget.userName);
    if(initialPage == -1){
      initialPage = 0;
    }
    super.initState();
  }

  double dragStart = 0;
  double dragEnd = 0;

  double tDy = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (pop){
        "onBack()".log();
        context.read<StoryController>().cancelTimer();
        context.read<UserStoryCubit>().updateUserStories(context.read<StoryController>().stories);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Consumer<StoryController>(
            builder: (BuildContext context, StoryController value, Widget? child) {
              return GestureDetector(
                onVerticalDragStart: (point) {
                  dragStart = point.globalPosition.dy;
                },
                onVerticalDragUpdate: (point) {
                  dragEnd = point.globalPosition.dy;

                  if (dragStart < dragEnd && (dragEnd - dragStart) > 120.0) {
                    Navigator.pop(context);
                  } else if (dragStart < dragEnd) {
                    setState(() {
                      tDy = dragEnd - dragStart;
                    });
                  }
                },
                onVerticalDragEnd: (p) {
                  "s- $dragStart, e- $dragEnd".log();
                  dragStart = dragEnd = 0;
                  setState(() {
                    tDy = 0;
                  });
                },
                child: Transform.translate(
                  offset: Offset(0, tDy),
                  child: CarouselSlider(
                    initialPage: initialPage,
                    controller: value.controller,
                    autoSliderTransitionTime: Duration(milliseconds: 500),
                    slideTransform: CubeTransform(),
                    children: value.stories
                        .map((e) => StoryContent(
                              story: e,
                            ))
                        .toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
