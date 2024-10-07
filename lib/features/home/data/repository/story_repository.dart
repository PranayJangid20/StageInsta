import 'package:stage_insta/features/home/data/source/dummy_storage.dart';
import 'package:stage_insta/features/home/domain/Entity/user_story.dart';
import 'package:stage_insta/features/home/domain/data_source/story_data_source.dart';
import 'package:stage_insta/features/home/domain/repository/story_repository.dart';

class StoryRepositoryImpl implements StoryRepository {

  final StoryDataSource _storage = DummyStorage();

  @override
  Future<List<UserStory>> fetchUserStory() async {
    var result = await _storage.loadUserStories();
    if (result != null && result.isNotEmpty) {
      return result.map((json) => UserStory.fromJson(json)).toList();
    }
    return [];
  }

  @override
  void storeUpdatedStory(List<UserStory> data) {
    List<Map<String, dynamic>> _data = [];

    for (var e in data) {
      _data.add(e.toJson());
    }

    _storage.storeUserStories(_data);
    return;
  }
}
