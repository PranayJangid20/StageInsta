import 'package:flutter/material.dart';
import 'package:stage_insta/features/story_view/presentation/widgets/story_content.dart';

class Storypage extends StatefulWidget {
  const Storypage({super.key});

  @override
  State<Storypage> createState() => _StorypageState();
}

class _StorypageState extends State<Storypage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: StoryContent(),
      
      ),
    );
  }
}
