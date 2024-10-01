import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stage_insta/service/navigator_service.dart';
import 'package:stage_insta/utils/gradient_border.dart';
import 'package:stage_insta/utils/helper_extensions.dart';
import 'package:stage_insta/utils/ui_helper.dart';

class StoryComponent extends StatelessWidget {
  StoryComponent({super.key});

  final nav = GetIt.instance<NavigatorService>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        nav.navigateTo("/storyView");
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
      width: 88,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(6),
                  child: CircleAvatar(
                    foregroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1506863530036-1efeddceb993?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHBvcnRyYWl0fGVufDB8fDB8fHww"),
                    radius: 38,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: GradientBorder(
                      borderGradient: LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.green,
                        ],
                      ),
                      width: 3.4,
                    )
                  ),),
              8.spaceY,
              Text(
                "User Name",
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
