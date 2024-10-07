import 'package:json_cache/json_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stage_insta/utils/helper_extensions.dart';

class CacheService {
  Future<Map<String, dynamic>?> loadCache(cacheKey) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      final JsonCacheMem jsonCache = JsonCacheMem(JsonCacheSharedPreferences(preferences));
      Map<String, dynamic>? data = await jsonCache.value(cacheKey);
      return data;
    }
    catch(e, stackTrace){
      // Handle any errors that occur during cache retrieval
      "Error retrieving cache for key: $cacheKey, error: $e".log();

      return null;  // Returning null if any failure occurs
    }
  }

  Future<void> storeCache(cacheKey, Map<String, dynamic> data) async {
    try {

      final SharedPreferences preferences = await SharedPreferences.getInstance();
      final JsonCacheMem jsonCache = JsonCacheMem(JsonCacheSharedPreferences(preferences));

      /// Saving profile and preferences data.
      jsonCache.refresh(cacheKey, data);
    }
    catch (e, stackTrace) {

      // Handle any errors that occur during the storing process
      "Error storing cache for key: $cacheKey, error: $e".log();

    }
  }
}