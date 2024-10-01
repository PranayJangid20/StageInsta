import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:stage_insta/common/app_constants.dart';
import 'package:stage_insta/service/token_refress.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NetworkService {
  static String toUrl = "";
  Dio dio = Dio();

  final _requestQueue = <Future>[];

  NetworkService() {
    // Dio Allow us to add Interceptors, using Interceptors we can watch, edit and start required process
    dio.interceptors.add(AuthInterceptor(dio));
  }

  SharedPreferences preferences = GetIt.instance<SharedPreferences>();

  Future<Map<String, dynamic>> get(String page) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String url = toUrl + page;

    // Wrap API call inside a Future
    var future = _get(url, sharedPreferences);
    // Add a completion callback to handle removing the completed future from the queue
    future.then((_) => _requestQueue.remove(future));
    _requestQueue.add(future); // Add future to the queue
    return future;
  }

  Future<Map<String, dynamic>> _get(
      String url, SharedPreferences sharedPreferences) async {
    Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();
    try {
      Response response = await dio.get(
        url,
        options: _getRequestOptions(sharedPreferences),
      );
      completer.complete(_fetchResponse(response));
    } catch (e) {
      completer.complete({'success': false, 'result': 501});
    }
    return completer.future;
  }

  Options _getRequestOptions(SharedPreferences sharedPreferences) {
    return Options(
      headers: {
        'Authorization':
            'Bearer ${sharedPreferences.getString(AppConstant.AccessTokens)}'
      },
    );
  }

  Future post({
    required String url,
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      var response = await dio.post(
        toUrl + url,
        data: body,
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${sharedPreferences.getString(AppConstant.AccessTokens)}',
            'Content-Type': 'application/json',
          },
        ),
      );
      return _fetchResponse(response);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future put({
    required String url,
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      var response = await dio.put(
        toUrl + url,
        data: body,
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${sharedPreferences.getString(AppConstant.AccessTokens)}',
            'Content-Type': 'application/json',
          },
        ),
      );
      return _fetchResponse(response);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future delete({required String url, Map<String, String>? headers}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      var response = await dio.delete(
        toUrl + url,
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${sharedPreferences.getString(AppConstant.AccessTokens)}',
            'Content-Type': 'application/json',
          },
        ),
      );
      return _fetchResponse(response);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static dynamic _fetchResponse(Response response) {
    // TODO: Refactor this method
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      return {'success': true, 'data': response.data};
    } else {
      return {
        'success': false,
        'status': response.statusCode,
        'data': response.data
      };
    }
  }
}
