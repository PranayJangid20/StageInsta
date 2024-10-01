import 'package:flutter/material.dart';

class AppConstant {
  static const AppListeningTo = 'listningTrack';
  static const AppListeningEpisode = 'listningEpisode';
  static const AppDownlodedEpisode = 'downloadedEpisode';
  static const AppDownlodedSeries = 'downloadedSeries';
  static const AccessTokens = 'accessTokens';
  static const RefressTokens = 'refressTokens';
  static const ShowcaseMicSearchHome = 'showcaseMicSearchHome';
  static const UserLang = 'userLang';
  static const UserLangExpire = 'userLangExpire';
  static const LangScript = 'langScript';
  static const LastShowLang = 'lastShowLang';
  static const UserReferred = 'userReferred';
  static const bannerShadow = BoxShadow(color: Colors.black12,offset: Offset(0, 4),blurRadius: 24);
}

enum UpdateType { FORCE, OPTIONAL, NONE }
