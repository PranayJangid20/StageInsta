import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:get_it/get_it.dart';
import 'package:stage_insta/features/home/domain/Entity/user_story.dart';
import 'package:stage_insta/features/home/presentation/cubit/user_story_cubit.dart';
import 'package:stage_insta/service/navigator_service.dart';
import 'package:stage_insta/utils/helper_extensions.dart';

class StoryController extends ChangeNotifier {
  NavigatorService nav = GetIt.instance<NavigatorService>();

  final CarouselSliderController _carouselController = CarouselSliderController();
  Timer? _storyTimer;
  int _currentUserIndex = 0;
  int _currentStoryIndex = 0;
  bool _isPaused = false;

  late UserStory ongoingUser;

  late List<UserStory> _stories;

  // Get carousel controller
  CarouselSliderController get controller => _carouselController;
  List<UserStory> get stories => _stories;
  int get storyIndex => _currentStoryIndex;

  setStories(List<UserStory> stories, initial) {
    _stories = stories;
    // currentUser = stories.first;
    // if(currentUser.stories!.length != currentUser.watched){
    //   storyToWatch = currentUser.watched??0;
    // }
    // currentStory = currentUser.stories![storyToWatch];

    int index = stories.indexWhere((user) => user.userName == initial);
    ongoingUser = stories[index];
    if((ongoingUser.watched??0)>=ongoingUser.stories!.length){
      ongoingUser.watched = 0;
    }
    startTimer();
    return index;

    // notifyListeners();
  }

  // Start the story timer
  void startTimer({int duration = 5}) {
    _storyTimer?.cancel();
    _storyTimer = Timer.periodic(Duration(seconds: duration), (timer) {
      "timer - ${timer.tick}".log();
      if (!_isPaused) {
        _nextStory();
        // storyVisited("userName");
      }
    });
  }

  void cancelTimer(){
    _storyTimer?.cancel();
  }

  void _nextStory(){
    _currentStoryIndex ++;
    storyVisited(ongoingUser.userName??"");
    if(_currentStoryIndex == ongoingUser.stories!.length){
      _currentStoryIndex = 0;
      _nextUser();
    }
    else{
      notifyListeners();
    }
  }

  void _previousStory(){
    _currentStoryIndex --;
    if(_currentStoryIndex == 0){
      goToPreviousStory();
    }
    else{
      notifyListeners();
    }
  }

  // Move to the next story
  void _nextUser() {
    _currentUserIndex++;
    _carouselController.nextPage();

    int index = _stories.indexWhere((test) => test.userName == ongoingUser.userName);
    if (index < _stories.length - 1) {
      ongoingUser = _stories[index + 1];
      if((ongoingUser.watched??0)>=ongoingUser.stories!.length){
        ongoingUser.watched = 0;
      }
    }
    else{
      nav.pop();
    }

    notifyListeners();
  }

  void storyVisited(String userName) {
    UserStory story = _stories.where((user) => user.userName == userName).first;

    int currentWatch = story.watched ?? 0;
    story.watched = currentWatch + 1;

    int index = _stories.indexWhere((test) => test.userName == userName);
    _stories[index] = story;

    if(ongoingUser.watched != ongoingUser.stories!.length+1) {
      ongoingUser.watched = currentWatch + 1;
    }
    "total - ${story.stories!.length}, watched - ${story.watched}".log();
    "total - ${ongoingUser.stories!.length}, watched - ${ongoingUser.watched}".log();

    startTimer();
    notifyListeners();
  }

  // Pause story when holding or tapping
  void pauseStory() {
    _isPaused = true;
    _storyTimer?.cancel();
  }

  // Resume the story when tap ends
  void resumeStory() {
    _isPaused = false;
    startTimer();
  }

  // Skip to the next story on right tap
  void skipToNextStory() {
    _nextUser();
  }

  // Go back to the previous story on left tap
  void goToPreviousStory() {
    if (_currentUserIndex > 0) {
      _currentUserIndex--;
      _carouselController.previousPage();
      _currentStoryIndex = _stories[_currentStoryIndex].stories!.length-1;

    }
  }

  // Dispose timer when done
  @override
  void dispose() {
    _storyTimer?.cancel();
    super.dispose();
  }
}
