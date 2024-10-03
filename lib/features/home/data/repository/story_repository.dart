import 'package:stage_insta/features/home/data/source/dummy_storage.dart';
import 'package:stage_insta/features/home/domain/Entity/user_story.dart';
import 'package:stage_insta/features/home/domain/repository/story_repository.dart';

class StoryRepositoryImpl implements StoryRepository {
  // we can pass data source local or network here

  final DummyStorage _storage = DummyStorage();

  @override
  Future<List<UserStory>> fetchUserStory() async {
    var result = await _storage.loadUserStories();
    if (result != null && result.isNotEmpty) {
      return result.map((json) => UserStory.fromJson(json)).toList();
    }
    return [];
  }

  @override
  void storeUpdatedStoryCache(List<UserStory> data) {
    var _data = [];

    for (var e in data) {
      _data.add(e.toJson());
    }

    _storage.storeCache(_data);
  }
}
