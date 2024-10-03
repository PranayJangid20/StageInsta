import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stage_insta/features/home/domain/Entity/user_story.dart';
import 'package:stage_insta/service/navigator_service.dart';
import 'package:stage_insta/utils/gradient_border.dart';
import 'package:stage_insta/utils/helper_extensions.dart';
import 'package:stage_insta/utils/open_story.dart';
import 'package:stage_insta/utils/ui_helper.dart';

class StoryComponent extends StatelessWidget {
  StoryComponent({super.key, required this.story});
  final UserStory story;

  final nav = GetIt.instance<NavigatorService>();

  @override
  Widget build(BuildContext context) {
    return OpenContainerWrapper(
      id: story.userName??"",
      closedChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          width: 88,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(6),
                child: CircleAvatar(
                  foregroundImage: NetworkImage(story.userImage??""),
                  radius: 38,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: (story.watched??0) == story.stories!.length? Border.all(color: Colors.grey, width: 2) : GradientBorder(
                      borderGradient: LinearGradient(colors: [
                        Color(0XFFf9ce34),
                        Color(0XFFee2a7b),
                        Color(0XFF6228d7),
                      ], stops: [
                        0.2,
                        1.0,
                        0.0
                      ], begin: Alignment.bottomLeft,
                        transform: GradientRotation(-0.4),),
                      width: 3.4,
                    )),
              ),
              8.spaceY,
              Text(
                story.userName??"",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: fsHeadLine6(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
