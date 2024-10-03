import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navigator_service.dart';

final locator = GetIt.I;
void setupLocator() async {
  locator.registerSingletonAsync(() async => await SharedPreferences.getInstance());
  locator.registerLazySingleton(()=>NavigatorService());
}