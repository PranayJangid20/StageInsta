import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stage_insta/features/home/data/repository/story_repository.dart';
import 'package:stage_insta/features/home/domain/Entity/user_story.dart';
import 'package:stage_insta/features/home/domain/repository/story_repository.dart';
import 'package:stage_insta/features/home/domain/services/story_services.dart';

part 'user_story_state.dart';

class UserStoryCubit extends Cubit<UserStoryState> {
  UserStoryCubit(this._storyService, this._repo) : super(UserStoryInitial());


  final StoryRepository _repo;
  final StoryService _storyService;

  List<UserStory> stories = [];

  // Our Models is not use with Equitable, and our model is only property for cubit state, this helps "is" to compare old state with new one
  // Using model with Equitable allow "is"(by Equitable package) to compares model properties also
  int i = 0;

  getUserStories() async {
    i++;
    emit(UserStoryLoading());
    List<UserStory> _stories = await _repo.fetchUserStory();
    stories = _stories;
    emit(UserStoryLoaded(stories: _stories, i: i));
  }

  updateUserStories(List<UserStory> data) {
    // Sorting the list
    stories = _storyService.sortStories(data);
    _repo.storeUpdatedStory(stories);
    i++;
    emit(UserStoryLoaded(stories: stories, i: i));
  }
}
