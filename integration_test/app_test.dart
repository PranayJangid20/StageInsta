import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:stage_insta/features/home/presentation/cubit/user_story_cubit.dart';
import 'package:stage_insta/features/story_view/presentation/provider/carousel_controller.dart';
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
      BlocProvider<UserStoryCubit>(create: (_) => UserStoryCubit()),
      ChangeNotifierProvider(
        create: (_) => StoryController(),
      ),
    ], child: MyApp()));

    await tester.pumpAndSettle();
    await Future.delayed(Duration(seconds: 2));
    final firstStory = find.text("Anna");
    await tester.tap(firstStory);

    await tester.pumpAndSettle(Duration(milliseconds: 50), EnginePhase.sendSemanticsUpdate, Duration(seconds: 62));

    // Pump the widget tree again to update the UI
    // await tester.pumpAndSettle();

    // Find the text and assert its existence
    expect(find.text('Instagram'), findsAny);
  });

  testWidgets("Story failure test", (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(providers: [
      BlocProvider<UserStoryCubit>(create: (_) => UserStoryCubit()),
      ChangeNotifierProvider(
        create: (_) => StoryController(),
      ),
    ], child: MyApp()));

    await tester.pumpAndSettle();
    await Future.delayed(Duration(seconds: 2));
    final firstStory = find.text("Anna");
    await tester.tap(firstStory);

    try {
      await tester.pumpAndSettle(Duration(milliseconds: 50), EnginePhase.sendSemanticsUpdate, Duration(seconds: 55));
    }
    catch(e){}
    // Pump the widget tree again to update the UI
    // await tester.pumpAndSettle();

    // Find the text and assert its existence
    expect(find.text("Message"), findsAny);
  });


  testWidgets("Drag to close test", (WidgetTester tester) async {
    // setupLocator();
    await tester.pumpWidget(MultiProvider(providers: [
      BlocProvider<UserStoryCubit>(create: (_) => UserStoryCubit()),
      ChangeNotifierProvider(
        create: (_) => StoryController(),
      ),
    ], child: MyApp()));

    final screenSize = tester.view.physicalSize;
    final dragStart = Offset(screenSize.width * 0.5, screenSize.height *0.3);
    await tester.pumpAndSettle();
    final firstStory = find.text("Anna");
    await tester.tap(firstStory);

    try {
      await tester.pumpAndSettle(Duration(milliseconds: 50), EnginePhase.sendSemanticsUpdate, Duration(seconds: 2));
    }
    catch(e){
      e.log();
    }

    await tester.timedDrag(find.byType(ContentArea).first, Offset(0, 300),Duration(milliseconds: 200), warnIfMissed: false);
    // Pump the widget tree again to update the UI
    await tester.pumpAndSettle();

    // Find the text and assert its existence
    expect(find.text('Instagram'), findsAny);
  });
}
