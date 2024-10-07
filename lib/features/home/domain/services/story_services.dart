import 'package:stage_insta/features/home/domain/Entity/user_story.dart';

class StoryService {
  List<UserStory> sortStories(List<UserStory> stories) {
    stories.sort((a, b) {
      int aWatchedAll = a.watched! == a.stories!.length ? 1 : 0;
      int bWatchedAll = b.watched! == b.stories!.length ? 1 : 0;
      return aWatchedAll.compareTo(bWatchedAll);
    });
    return stories;
  }
}
