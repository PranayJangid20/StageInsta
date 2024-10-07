import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:stage_insta/features/home/data/repository/story_repository.dart';
import 'package:stage_insta/features/home/domain/services/story_services.dart';
import 'package:stage_insta/features/home/presentation/cubit/user_story_cubit.dart';
import 'package:stage_insta/features/story_view/presentation/provider/story_controller.dart';
import 'package:stage_insta/features/story_view/presentation/widgets/content_area.dart';
import 'package:stage_insta/main.dart';
import 'package:integration_test/integration_test.dart';
import 'package:stage_insta/service/locator.dart';
import 'package:stage_insta/utils/helper_extensions.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Story forward test", (WidgetTester tester) async {
    setupLocator();
    await tester.pumpWidget(MultiProvider(providers: [
      BlocProvider<UserStoryCubit>(
          create: (_) => UserStoryCubit(GetIt.instance<StoryService>(), GetIt.I<StoryRepositoryImpl>())),
      ChangeNotifierProvider(
        create: (_) => StoryController(),
      ),
    ], child: MyApp()));

    await tester.pumpAndSettle();
    await Future.delayed(Duration(seconds: 2));
    final firstStory = find.text("Anna");
    await tester.tap(firstStory);

    try {
      await tester.pumpAndSettle(Duration(milliseconds: 50), EnginePhase.sendSemanticsUpdate, Duration(seconds: 74));
    } catch (e) {
      e.log();
    }

    // Pump the widget tree again to update the UI
    // await tester.pumpAndSettle();

    // Find the text and assert its existence
    expect(find.text('Instagram'), findsAny);
  });

  testWidgets("Story pause test", (WidgetTester tester) async {

    await tester.pumpWidget(MultiProvider(providers: [
      BlocProvider<UserStoryCubit>(
          create: (_) => UserStoryCubit(GetIt.instance<StoryService>(), GetIt.I<StoryRepositoryImpl>())),
      ChangeNotifierProvider(
        create: (_) => StoryController(),
      ),
    ], child: MyApp()));

    await tester.pumpAndSettle();
    await Future.delayed(Duration(seconds: 2));
    final firstStory = find.text("Anna");
    await tester.tap(firstStory);

    try {
      await tester.pumpAndSettle(Duration(milliseconds: 50), EnginePhase.sendSemanticsUpdate, Duration(seconds: 2));
    } catch (e) {
      e.log();
    }

    // Start the gesture for the long press
    final gesture = await tester.startGesture(tester.getCenter(find.byType(ContentArea).first));

    try {
      await tester.pumpAndSettle(Duration(milliseconds: 50), EnginePhase.sendSemanticsUpdate, Duration(seconds: 7));
    } catch (e) {
      e.log();
    }

    // End the gesture
    await gesture.cancel();

    // Find the widget using a predicate
    final foundWidget = find.byWidgetPredicate((widget) {
      // Check if the widget is of a specific type and has the desired property
      if (widget is CachedNetworkImage) {
        return widget.imageUrl == "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D";
      }
      return false; // If not a Text widget, return false
    });

    // Find the text and assert its existence
    expect(foundWidget, findsAny);
  });

  // Story drag to close
  testWidgets("Drag to close test", (WidgetTester tester) async {
    // setupLocator();
    await tester.pumpWidget(MultiProvider(providers: [
      BlocProvider<UserStoryCubit>(
          create: (_) => UserStoryCubit(GetIt.instance<StoryService>(), GetIt.I<StoryRepositoryImpl>())),
      ChangeNotifierProvider(
        create: (_) => StoryController(),
      ),
    ], child: MyApp()));

    final screenSize = tester.view.physicalSize;
    final dragStart = Offset(screenSize.width * 0.5, screenSize.height * 0.3);
    await tester.pumpAndSettle();
    final firstStory = find.text("Anna");
    await tester.tap(firstStory);

    try {
      await tester.pumpAndSettle(Duration(milliseconds: 50), EnginePhase.sendSemanticsUpdate, Duration(seconds: 2));
    } catch (e) {
      e.log();
    }

    await tester.timedDrag(find.byType(ContentArea).first, Offset(0, 300), Duration(milliseconds: 200),
        warnIfMissed: false);
    // Pump the widget tree again to update the UI
    await tester.pumpAndSettle();

    // Find the text and assert its existence
    expect(find.text('Instagram'), findsAny);
  });
}
