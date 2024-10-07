abstract class StoryDataSource {
  Future<List?> loadUserStories(); // Returns data (List<Map<String, dynamic>>)
  Future<void> storeUserStories(List<Map<String, dynamic>> data);
}