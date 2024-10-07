import 'package:stage_insta/features/home/domain/Entity/user_story.dart';

abstract class StoryRepository{
  Future<List<UserStory>> fetchUserStory();
  void storeUpdatedStory(List<UserStory> data);
  // we can define various function
}