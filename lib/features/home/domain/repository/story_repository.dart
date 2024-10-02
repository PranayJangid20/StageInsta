import 'package:stage_insta/features/home/domain/Entity/user_story.dart';

abstract class StoryRepository{
  Future<List<UserStory>> fetchUserStory();
  // we can define various function
}