import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_insta/features/story_view/presentation/provider/carousel_controller.dart';

class RunningBar extends StatefulWidget {
  const RunningBar({super.key});

  @override
  State<RunningBar> createState() => _RunningBarState();
}

class _RunningBarState extends State<RunningBar> {


  @override
  Widget build(BuildContext context) {
    if(kDebugMode){
      // if app is in "Test Mode" or "Debug Mode", It will display simple LinearProgressIndicator
      return LinearProgressIndicator();
    }
    return Consumer<StoryController>(
      builder: (context, value, child) {
        // else, It will display LinearProgressIndicator live progress
        return LinearProgressIndicator(value: value.watchPercentage,);
      },
    );
  }
}
