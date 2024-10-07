import 'package:json_cache/json_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stage_insta/common/app_constants.dart';
import 'package:stage_insta/features/home/domain/data_source/story_data_source.dart';
import 'package:stage_insta/features/home/domain/services/cache_service.dart';
import 'package:stage_insta/utils/helper_extensions.dart';

class DummyStorage implements StoryDataSource {

  final CacheService cacheService = CacheService();

  final List _data = [
    {
      "userName": "Anna",
      "userImage":
          "https://images.unsplash.com/photo-1506863530036-1efeddceb993?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHBvcnRyYWl0fGVufDB8fDB8fHww",
      "stories": [
        "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
        "https://images.unsplash.com/photo-1479936343636-73cdc5aae0c3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
        "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHBvcnRyYWl0fGVufDB8fDB8fHww",
        "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHBvcnRyYWl0fGVufDB8fDB8fHww"
      ],
      "watched": 0,
      "commneting": true,
      "likablity": true
    },
    {
      "userName": "Stage",
      "userImage": "https://www.stage.in/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fstage.3f6d9116.png&w=96&q=75",
      "stories": [
        "https://images.unsplash.com/photo-1479936343636-73cdc5aae0c3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
        "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
        "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHBvcnRyYWl0fGVufDB8fDB8fHww",
        "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHBvcnRyYWl0fGVufDB8fDB8fHww"
      ],
      "watched": 0,
      "commneting": false,
      "likablity": true
    },
    {
      "userName": "_xyz_",
      "userImage": "https://www.stage.in/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fstage.3f6d9116.png&w=96&q=75",
      "stories": [
        "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
        "https://images.unsplash.com/photo-1479936343636-73cdc5aae0c3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
        "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHBvcnRyYWl0fGVufDB8fDB8fHww"
      ],
      "watched": 0,
      "commneting": false,
      "likablity": false
    },
    {
      "userName": "influenza",
      "userImage": "https://www.stage.in/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fstage.3f6d9116.png&w=96&q=75",
      "stories": [
        "https://images.unsplash.com/photo-1479936343636-73cdc5aae0c3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
        "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
        "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHBvcnRyYWl0fGVufDB8fDB8fHww"
      ],
      "watched": 0,
      "commneting": true,
      "likablity": true
    }
  ];

  @override
  Future<List?> loadUserStories() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    // Checking for Cache
    List? data = await loadCache();

    //Mimic Network call
    if (data == null) {
      await Future.delayed(Duration(seconds: 2));

      String apiData = "apiData";

      /// Saving profile and preferences data.
      final JsonCacheMem jsonCache = JsonCacheMem(JsonCacheSharedPreferences(preferences));
      jsonCache.refresh(apiData, {"data": _data}).onError((e, s) {
        e.toString().log();
      });

      return _data;
    }

    // Cache Available, passing Cache
    return data;
  }

  //Note: Cache things can be in separate class, following "SRP"
  Future<List?> loadCache() async {
    var data = await cacheService.loadCache(AppConstant.StoryCacheKey);
    if (data == null) {

      "Cache Not Available".log();
      return null;

    } else {

      "Cache Available".log();
      return data["data"];

    }
  }

  @override
  Future<void> storeUserStories(List<Map<String, dynamic>> data) async {
    await cacheService.storeCache(AppConstant.StoryCacheKey, {"data": data});

  }

}

// Note: Same can be
// class LocalStorage implements StoryDataSource
// class NetworkStorage implements StoryDataSource