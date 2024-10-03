import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stage_insta/features/home/data/repository/story_repository.dart';
import 'package:stage_insta/features/home/domain/Entity/user_story.dart';

part 'user_story_state.dart';

class UserStoryCubit extends Cubit<UserStoryState> {
  UserStoryCubit() : super(UserStoryInitial());


  StoryRepositoryImpl _repo = StoryRepositoryImpl();
  List<UserStory> stories = [];

  // Our Models is not implemented with Equitable, and our model is only property for cubit state, this helps "is" to compare old state with new one
  // Implementing model with Equitable allow "is"(by Equitable package) to compares model properties also
  int i = 0;

  getUserStories() async {
    i++;
    emit(UserStoryLoading());
    List<UserStory> _stories = await _repo.fetchUserStory();
    stories = _stories;
    emit(UserStoryLoaded(stories: _stories, i: i));
  }

  updateUserStories(List<UserStory> _stories) {
    // Sorting the list
    _stories.sort((a, b) {
      int aWatchedAll = a.watched! == a.stories!.length ? 1 : 0;
      int bWatchedAll = b.watched! == b.stories!.length ? 1 : 0;
      return aWatchedAll.compareTo(bWatchedAll);
    });
    stories = _stories;
    _repo.storeUpdatedStoryCache(stories);
    i++;
    emit(UserStoryLoaded(stories: _stories, i: i));
  }
}
