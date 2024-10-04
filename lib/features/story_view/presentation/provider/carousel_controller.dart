import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:get_it/get_it.dart';
import 'package:stage_insta/features/home/domain/Entity/user_story.dart';
import 'package:stage_insta/service/navigator_service.dart';
import 'package:stage_insta/utils/helper_extensions.dart';

class StoryController extends ChangeNotifier {
  NavigatorService nav = GetIt.instance<NavigatorService>();

  final CarouselSliderController _carouselController = CarouselSliderController();
  Timer? _intervalTimer;
  Timer? _storyTimer;
  int _currentUserIndex = 0;
  int _currentStoryIndex = 0;
  bool _isPaused = false;

  int firstStory = 0;

  double _watchPercent = 0.02;

  late UserStory ongoingUser;

  late List<UserStory> _stories;

  CarouselSliderController get controller => _carouselController;
  List<UserStory> get stories => _stories;
  int get storyIndex => _currentStoryIndex;
  int get userIndex => _currentUserIndex;
  Timer? get timer => _storyTimer;
  double get watchPercentage => _watchPercent;

  setStories(List<UserStory> stories, initial) {
    _stories = List<UserStory>.from(stories);

    firstStory = _stories.first.watched ?? 0;
    debugPrint((firstStory == _stories.first.watched).toString());

    int index = stories.indexWhere((user) => user.userName == initial);

    _currentUserIndex = index;

    // NOTE: Will set value by .copyWith method, it will make sure no reference is passed
    ongoingUser = stories[index].copyWith();
    debugPrint((firstStory == _stories.first.watched).toString());

    if ((ongoingUser.watched ?? 0) >= ongoingUser.stories!.length) {
      ongoingUser.watched = 0;
    }
    debugPrint((firstStory == _stories.first.watched).toString());

    _currentStoryIndex = ongoingUser.watched!;
    debugPrint((firstStory == _stories.first.watched).toString());

    // if (ongoingUser.watched != ongoingUser.stories!.length) {
    storyVisited(ongoingUser.userName ?? "", _currentStoryIndex);
    // }

    startTimer();
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
    return index;
  }

  void nextStory() {
    "$_currentUserIndex  - ${(_stories.length - 1)}".log();
    if (_currentStoryIndex >= ongoingUser.stories!.length - 1) {
      if (_currentUserIndex < (_stories.length - 1)) {
        _carouselController.nextPage();
      } else {
        cancelTimer();
        nav.pop();
      }
    } else {
      _currentStoryIndex++;
      if (ongoingUser.watched != ongoingUser.stories!.length) {
        storyVisited(ongoingUser.userName ?? "", _currentStoryIndex);
      }
      notifyListeners();
    }

    startTimer();
  }

  void previousStory() {
    if (_currentStoryIndex >= 0) {
      _currentStoryIndex--;

      // Story visit dose not required, by this action user will watch already visited stories
      // Or go to previous user story (for that case we already handled Story visit)

      notifyListeners();
    }

    if (_currentStoryIndex < 0) {
      _currentStoryIndex = 0;
      notifyListeners();

      _carouselController.previousPage();
    }
  }

  // Move to the next story
  void nextUser(int slideIndex) {
    if (slideIndex >= _currentUserIndex) {
      _currentUserIndex = slideIndex;

      if (_currentUserIndex < _stories.length) {
        startTimer();

        notifyListeners();

        Future.delayed(const Duration(milliseconds: 200), () {
          ongoingUser = _stories[slideIndex].copyWith();
          _currentStoryIndex = ongoingUser.watched ?? 0;

          if (ongoingUser.watched == ongoingUser.stories!.length) {
            _currentStoryIndex = 0;
          }

          if (ongoingUser.watched != ongoingUser.stories!.length) {
            storyVisited(ongoingUser.userName ?? "", _currentStoryIndex);
          }

          if ((ongoingUser.watched ?? 0) >= ongoingUser.stories!.length) {
            ongoingUser.watched = 0;
            // "ongoingUser.watched = 0".log();
          }

          notifyListeners();
        });
      }
    } else {
      previousUser(slideIndex);
    }
  }

  void previousUser(int slideIndex) {
    int index = _currentStoryIndex;
    if (index <= _stories.length - 1) {
      startTimer();

      notifyListeners();

      Future.delayed(const Duration(milliseconds: 500), () {
        _currentUserIndex = slideIndex;
        ongoingUser = _stories[_currentUserIndex].copyWith();
        _currentStoryIndex = ongoingUser.watched ?? 0;

        if (ongoingUser.watched != ongoingUser.stories!.length) {
          storyVisited(ongoingUser.userName ?? "", _currentStoryIndex);
        }
        // if ((ongoingUser.watched ?? 0) >= ongoingUser.stories!.length) {
        //   ongoingUser.watched = 0;
        //   // "ongoingUser.watched = 0".log();
        // }

        "on previous : prevStory i - ${_currentStoryIndex}".log();
        notifyListeners();
      });
    }
  }

  void storyVisited(String userName, int forIndex) {
    UserStory story = _stories.where((user) => user.userName == userName).first;
    int currentWatch = story.watched ?? 0;

    "For ${(story.watched ?? 0)} - ${forIndex} == ${!((story.watched ?? 0) > forIndex)}".log();
    if (story.watched == story.stories!.length || (story.watched ?? 0) > forIndex) {
      return;
    }

    "StoryVisit Update : $userName".log();
    story.watched = currentWatch + 1;

    story.watched!.clamp(0, story.stories!.length);

    // -----------------------------------------------------------------------
    // int index = _stories.indexWhere((test) => test.userName == userName);
    _stories[_currentUserIndex] = story;
    // -----------------------------------------------------------------------

    // if (ongoingUser.watched != ongoingUser.stories!.length + 1) {
    //   ongoingUser.watched = currentWatch + 1;
    //   ongoingUser.watched!.clamp(0, ongoingUser.stories!.length);
    // }

    Future.delayed(
      Duration.zero,
      () => notifyListeners(),
    );

    // "${story.stories!.length} - ${story.watched}".log();
  }

  // Start the story timer
  void startTimer({int duration = 5000}) {
    _watchPercent = 0.02;
    // notifyListeners();
    _intervalTimer?.cancel();
    _storyTimer?.cancel();
    _intervalTimer = Timer.periodic(Duration(milliseconds: duration), (timer) {
      _watchPercent = 0.02;
      // "timer - ${timer.tick}".log();
      if (!_isPaused) {
        nextStory();
      }
    });
    _storyTimer = Timer.periodic(Duration(milliseconds: 100), (t) {
      _watchPercent += 0.02;

      // debugPrint((firstStory == _stories.first.watched).toString());

      // "User : ${ongoingUser.userName} - Story : ${_currentStoryIndex}".log();
      notifyListeners();
    });
  }

  void cancelTimer() {
    _intervalTimer?.cancel();
    _storyTimer?.cancel();
  }

  // Pause story when holding or tapping
  void pauseStory() {
    _isPaused = true;

    cancelTimer();
    notifyListeners();
  }

  // Resume the story when tap ends
  void resumeStory() {
    _isPaused = false;
    double startFrom = 5000 * _watchPercent;
    startTimer(duration: (5000 - startFrom.floor()));
    notifyListeners();
  }

  // Dispose timer when done
  @override
  void dispose() {
    _intervalTimer?.cancel();
    _storyTimer?.cancel();
    super.dispose();
  }
}
