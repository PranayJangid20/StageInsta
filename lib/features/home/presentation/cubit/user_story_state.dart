part of 'user_story_cubit.dart';

abstract class UserStoryState extends Equatable {
  const UserStoryState();
}

class UserStoryInitial extends UserStoryState {
  @override
  List<Object> get props => [];
}

class UserStoryLoading extends UserStoryState {
  @override
  List<Object> get props => [];
}

class UserStoryLoaded extends UserStoryState {
  final List<UserStory> stories;
  final int i;

  const UserStoryLoaded({required this.stories, required this.i});
  @override
  List<Object> get props => [stories, i];
}
