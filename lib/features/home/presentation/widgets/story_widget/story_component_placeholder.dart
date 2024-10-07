import 'package:flutter/material.dart';
import 'package:stage_insta/common/common.dart';
import 'package:stage_insta/utils/helper_extensions.dart';

class StoryComponentPlaceholder extends StatelessWidget {
  const StoryComponentPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 88,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              child: const CircleSkeleton(size: 76,),
            ),
            8.spaceY,
            const Skeleton(height: 14,width: 88,)
          ],
        ),
      ),
    );
  }
}
