import 'package:flutter/material.dart';

// Note : This class will be Singleton Class and responsible to control named navigation across project
class NavigatorService {

  // This is navigation key it  is bind with MaterialApp "navigationKey" and using this key we can control navigation
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Responsible to replace existing page with new page in the stack
  Future<dynamic> navigateAndReplaceTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  // Responsible to add new page on top of existing page in the stack
  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  void pop(){
    navigatorKey.currentState!.pop();
  }

  // Add other navigation methods as needed
}
