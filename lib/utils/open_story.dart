import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:stage_insta/features/home/domain/Entity/user_story.dart';
import 'package:stage_insta/features/story_view/presentation/ui/story_page.dart';

class OpenContainerWrapper extends StatefulWidget {
  const OpenContainerWrapper({super.key,
    required this.id,
    required this.closedChild,
  });

  final String id;
  final Widget closedChild;

  @override
  State<OpenContainerWrapper> createState() => _OpenContainerWrapperState();
}

class _OpenContainerWrapperState extends State<OpenContainerWrapper> {
  bool isOpening = false;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openBuilder: (context, closedContainer) {
        return StoryPage(userName: widget.id,);
      },
      openColor: Colors.black,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      closedElevation: 0,
      closedColor: Colors.transparent,
      middleColor: Colors.white,
      closedBuilder: (context, openContainer) {
        return InkWell(
          onTap: () {
            setState(() {
              isOpening = true;
            });

            Future.delayed(Duration(milliseconds: 600), () {
              setState(() {
                isOpening = false;
              });
            });
            openContainer();
          },
          splashColor: Colors.transparent,
          overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
          child: isOpening
              ? SizedBox(
                  width: 104,
                )
              : widget.closedChild,
        );
      },
    );
  }
}
