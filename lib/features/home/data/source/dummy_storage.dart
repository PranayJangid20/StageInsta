import 'package:json_cache/json_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stage_insta/utils/helper_extensions.dart';

class DummyStorage {
  final List _data = [
    {
      "userName": "Anna",
      "userImage":
          "https://images.unsplash.com/photo-1506863530036-1efeddceb993?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHBvcnRyYWl0fGVufDB8fDB8fHww",
      "stories": [
        "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
        "https://images.unsplash.com/photo-1479936343636-73cdc5aae0c3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
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

  Future<List?> loadCache() async {
    String apiData = "apiData";
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final JsonCacheMem jsonCache = JsonCacheMem(JsonCacheSharedPreferences(preferences));
    bool available = await jsonCache.contains(apiData);
    if (!available) {
      "Cache Not Available".log();
      return null;
    } else {
      Map? data = await jsonCache.value(apiData);
      if (data == null) {
        return null;
      }

      "Cache Available".log();
      return data["data"];
    }
  }

  void storeCache(List data) async {
    String apiData = "apiData";
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final JsonCacheMem jsonCache = JsonCacheMem(JsonCacheSharedPreferences(preferences));

    /// Saving profile and preferences data.
    jsonCache.refresh(apiData, {"data": data}).onError((e, s) {
      e.toString().log();
    });
  }
}
