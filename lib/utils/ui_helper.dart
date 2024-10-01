import 'package:flutter/material.dart';

import '../common/app_colors.dart';

TextStyle fsHeadLine0(
        {BuildContext? context,
        required double fontSize,
        Color color = AppColors.blackShade1,
        FontWeight fontWeight = FontWeight.normal,
        letterSpacing = 0.0,
        FontStyle fontStyle = FontStyle.normal}) =>
    TextStyle(color: color, fontWeight: fontWeight, fontSize: 24, fontFamily: "Roboto", letterSpacing: letterSpacing);

TextStyle fsHeadLine1(
        {BuildContext? context,
        Color color = AppColors.blackShade1,
        FontWeight fontWeight = FontWeight.normal,
        letterSpacing = 0.0,
        FontStyle fontStyle = FontStyle.normal}) =>
    TextStyle(color: color, fontWeight: fontWeight, fontSize: 24, fontFamily: "Roboto", letterSpacing: letterSpacing);

TextStyle fsHeadLine2(
        {BuildContext? context,
        Color color = AppColors.blackShade1,
        FontWeight fontWeight = FontWeight.normal,
        letterSpacing = 0.0,
        upper = false}) =>
    TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: !upper ? 22 : 23,
        fontFamily: "Roboto",
        letterSpacing: letterSpacing);

TextStyle fsHeadLine3(
        {BuildContext? context,
        Color color = AppColors.blackShade1,
        FontWeight fontWeight = FontWeight.normal,
        letterSpacing = 0.0,
        FontStyle fontStyle = FontStyle.normal,
        upper = false}) =>
    TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: !upper ? 20 : 21,
        fontFamily: "Roboto",
        fontStyle: fontStyle,
        letterSpacing: letterSpacing);

TextStyle fsHeadLine4(
        {BuildContext? context,
        Color color = AppColors.blackShade1,
        FontWeight fontWeight = FontWeight.normal,
        letterSpacing = 0.0,
        TextDecoration textDecoration = TextDecoration.none,
        upper = false}) =>
    TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: context == null
            ? !upper
                ? 18
                : 19
            : MediaQuery.of(context).size.height * 0.014,
        fontFamily: "Roboto",
        decoration: textDecoration,
        letterSpacing: letterSpacing);

TextStyle fsHeadLine5(
        {BuildContext? context,
        Color color = AppColors.blackShade1,
        FontWeight fontWeight = FontWeight.normal,
        letterSpacing = 0.0,
        TextDecoration textDecoration = TextDecoration.none,
        upper = false,
        FontStyle fontStyle = FontStyle.normal}) =>
    TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: context == null
            ? !upper
                ? 16
                : 17
            : MediaQuery.of(context).size.height * 0.014,
        fontFamily: "Roboto",
        fontStyle: fontStyle,
        decoration: textDecoration,
        letterSpacing: letterSpacing);

TextStyle fsHeadLine6(
        {BuildContext? context,
        Color color = AppColors.blackShade1,
        FontWeight fontWeight = FontWeight.normal,
        FontStyle fontStyle = FontStyle.normal,
          TextDecoration textDecoration = TextDecoration.none,
        letterSpacing = 0.0,
        upper = false}) =>
    TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: context == null
            ? !upper
                ? 14
                : 15
            : MediaQuery.of(context).size.height * 0.014,
        fontStyle: fontStyle,
        fontFamily: "Roboto",
        decoration: textDecoration,
        letterSpacing: letterSpacing);

TextStyle fsHeadLine7(
        {BuildContext? context,
        Color color = AppColors.blackShade1,
        FontWeight fontWeight = FontWeight.normal,
        upper = false}) =>
    TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: 12,
      fontFamily: "Roboto",
    );

TextStyle fsHeadLine8(
        {BuildContext? context,
        Color color = AppColors.blackShade1,
        FontWeight fontWeight = FontWeight.normal,
        upper = false}) =>
    TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: 10,
      fontFamily: "Roboto",
    );

TextStyle fsHeadLine9(
        {BuildContext? context,
        Color color = AppColors.blackShade1,
        FontWeight fontWeight = FontWeight.normal,
        upper = false}) =>
    TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: 8,
      fontFamily: "Roboto",
    );

RichText DynamicRichText(String text,
    {required TextStyle fontStyle,
    TextStyle? boldStyle,
    TextStyle? italicStyle,
    TextAlign textAling = TextAlign.left}) {
  final RegExp boldPattern = RegExp(r'\*\*(.*?)\*\*');
  final RegExp italicPattern = RegExp(r'_(.*?)_');

  List<InlineSpan> textSpans = [];
  final boldMatches = boldPattern.allMatches(text);
  final italicMatches = italicPattern.allMatches(text);

  List<Match> allMatches = [...boldMatches, ...italicMatches];
  allMatches.sort((a, b) => a.start.compareTo(b.start));

  int currentPosition = 0;

  for (Match match in allMatches) {
    final normalText = text.substring(currentPosition, match.start);
    final matchedText = text.substring(match.start, match.end);

    if (normalText.isNotEmpty) {
      textSpans.add(TextSpan(text: normalText, style: fontStyle));
    }

    if (matchedText.startsWith('**') && matchedText.endsWith('**')) {
      textSpans.add(TextSpan(
        text: matchedText.substring(2, matchedText.length - 2),
        style: TextStyle(fontWeight: FontWeight.bold),
      ));
    } else if (matchedText.startsWith('_') && matchedText.endsWith('_')) {
      textSpans.add(TextSpan(
        text: matchedText.substring(1, matchedText.length - 1),
        style: TextStyle(fontStyle: FontStyle.italic),
      ));
    }

    currentPosition = match.end;
  }

  // Add any remaining text after the last match
  if (currentPosition < text.length) {
    textSpans.add(TextSpan(text: text.substring(currentPosition), style: fontStyle));
  }

  return RichText(
    text: TextSpan(children: textSpans, style: fontStyle),
    textAlign: textAling,
  );
}
