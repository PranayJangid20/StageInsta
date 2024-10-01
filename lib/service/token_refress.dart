import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:stage_insta/common/app_constants.dart';
import 'package:stage_insta/service/navigator_service.dart';
import 'package:stage_insta/service/network_service.dart';
import 'package:stage_insta/utils/helper_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

//This class handles refreshing user Access token
class AuthInterceptor extends InterceptorsWrapper {
  final Dio dio;
  var client = http.Client();
  AuthInterceptor(this.dio);

  bool _isRefreshing = false;

  final List<DioException> _requestsNeedRetry = [];

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPreferences preferences = GetIt.instance<SharedPreferences>();
    final accessToken = preferences.getString(AppConstant.AccessTokens);
    options.headers['authorization'] = 'Bearer $accessToken';
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final response = err.response;
    if (response != null && response.statusCode == 401) {
      if (!_isRefreshing) {
        _isRefreshing = true;
        _requestsNeedRetry.add(err);
        final isRefreshSuccess = await refreshToken();

        _isRefreshing = false;

        if (isRefreshSuccess) {
          for (var element in _requestsNeedRetry) {
            try {
              handler.resolve(await _retry(element.requestOptions));
            } catch (e) {
              e.toString().log();
            }
          }

          return;
        } else {
          "refresh fail".log();

          _requestsNeedRetry.clear();
          // Here, refresh token failed
          // if refresh fail, force logout user here and navigate to Login page
        }
      } else {
        _requestsNeedRetry.add(err);
      }
    } else {
      return handler.next(err);
    }
  }

  Future<bool> refreshToken() async {
    "Refresh Token".log();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var response = await client.post(
        Uri.parse('${NetworkService.toUrl}/v1/auth/refresh-tokens'),
        body: {
          'token': '${sharedPreferences.getString(AppConstant.RefressTokens)}',
        });

    "Refresh fetch complete".log();
    if (response.statusCode == 202) {
      "Refresh Token OKKKKKKKK!!!!!!!!!!!!".log();
      var responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      sharedPreferences.setString(
          AppConstant.AccessTokens, responseJson['access']['token']);
      sharedPreferences.setString(
          AppConstant.RefressTokens, responseJson['refresh']['token']);
      return true;
    } else {
      "Refresh Token Expire!!!!!!!!!!!!".log();
      sharedPreferences.clear();

      // if refresh fails or Refresh token expires we will throw user to Login Screen
      GetIt.instance<NavigatorService>().navigateAndReplaceTo('/login');
      // navigator!.pushNamedAndRemoveUntil('/appRestart', (route) => false);
      return false;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions request0ptions) async {
    final options =
        Options(method: request0ptions.method, headers: request0ptions.headers);

    return dio.request<dynamic>(request0ptions.path,
        data: request0ptions.data,
        queryParameters: request0ptions.queryParameters,
        options: options);
  }
}
