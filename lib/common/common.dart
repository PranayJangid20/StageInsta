import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:stage_insta/common/app_colors.dart';
import 'package:stage_insta/utils/helper_extensions.dart';
import 'package:stage_insta/utils/ui_helper.dart';
//import 'package:gradient_borders/box_borders/gradient_box_border.dart';

final kInnerDecoration = BoxDecoration(
  color: Colors.white,
  border: Border.all(color: Colors.white),
  borderRadius: BorderRadius.circular(32),
);

kGradientBoxDecoration(List<Color> gradient) => BoxDecoration(
      gradient: LinearGradient(colors: [Colors.black, Colors.redAccent]),
      border: Border.all(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(32),
    );

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(8 / 2),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04), borderRadius: const BorderRadius.all(Radius.circular(8))),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({Key? key, this.size = 24}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}

String formatDateFromMilliseconds(int timestamp) {
  final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final String formattedDate = DateFormat('d MMMM y').format(dateTime);
  return formattedDate;
}

String formatTimestampToDuration(int timestampInMilliseconds) {
  timestampInMilliseconds = timestampInMilliseconds - DateTime.now().millisecondsSinceEpoch;
  final int seconds = (timestampInMilliseconds / 1000).round();
  final int minutes = (seconds / 60).floor();
  final int hours = (minutes / 60).floor();
  final int days = (hours / 24).floor();

  final List<String> parts = [];
  if (days > 0) parts.add('${days.toString()} day${days > 1 ? 's' : ''}');
  if (hours > 0) parts.add('${hours.remainder(24).toString()} hour${hours > 1 ? 's' : ''}');
  if (minutes > 0) {
    parts.add(
        '${minutes.remainder(60).toString()} min${minutes > 1 ? 's' : ''} ${minutes.remainder(60) < 1 ? '${seconds.remainder(60)}sec' : ''} ');
  }
  if (minutes == 0 && seconds < 60) parts.add('${seconds.toString()} sec');

  if (seconds < 0) parts.add('LIVE');

  return parts.join(' ');
}

String convertEpochToDateFormat(int millis) {
  // Define the format
  DateFormat formatter = DateFormat('d MMMM h a');

  // Convert milliseconds since epoch to DateTime
  DateTime date = DateTime.fromMillisecondsSinceEpoch(millis);

  // Return the formatted date
  return formatter.format(date);
}

String formatTimestampToDurationSec(int timestampInMilliseconds) {
  timestampInMilliseconds = timestampInMilliseconds - DateTime.now().millisecondsSinceEpoch;
  final int seconds = (timestampInMilliseconds / 1000).round();
  final int minutes = (seconds / 60).floor();
  final int hours = (minutes / 60).floor();
  final int days = (hours / 24).floor();

  final List<String> parts = [];
  if (days > 0) parts.add('${days.toString()} day${days > 1 ? 's' : ''}');
  if (hours > 0) parts.add('${hours.remainder(24).toString()} hour${hours > 1 ? 's' : ''}');
  if (minutes > 0) parts.add('${minutes.remainder(60).toString()} min${minutes > 1 ? 's' : ''}');
  if (seconds > 0) parts.add('${seconds.remainder(60).toString()} sec${seconds > 1 ? 's' : ''}');

  return parts.join(' ');
}

// formatMillisToMin({required int milliseconds}) {
//   int totalSeconds = milliseconds ~/ 1000;
//   int minutes = totalSeconds ~/ 60;
//   AppString appString = GetIt.instance<AppString>();
//   String formattedTime = "${minutes} ${minutes > 1 ? StringEnums.mins.name : StringEnums.min.name}";
//   return formattedTime;
// }

class AppExamButton extends StatelessWidget {
  final String text;
  final onTap;
  final bool enable;
  const AppExamButton({Key? key, required this.text, this.onTap, this.enable = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enable ? onTap : () {},
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: enable ? AppColors.buttonEnabeleColor : AppColors.grayShade6,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(text,
                style: fsHeadLine3(
                    fontWeight: FontWeight.w600, color: enable ? AppColors.blackShade4 : AppColors.grayShade3))),
      ),
    );
  }
}

class AppOptionalButton extends StatelessWidget {
  final String text;
  final onTap;
  final bool enable;
  const AppOptionalButton({Key? key, required this.text, this.onTap, this.enable = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enable ? onTap : () {},
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(color: enable ? AppColors.grayShade1 : AppColors.grayShade2),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            text,
            style:
                fsHeadLine3(fontWeight: FontWeight.w600, color: enable ? AppColors.grayShade1 : AppColors.grayShade2),
          ),
        ),
      ),
    );
  }
}

Widget appError({required String text}) {
  return Column(
    children: [
      8.spaceY,
      Row(
        children: [
          const Icon(
            Icons.error_outlined,
            color: AppColors.red100,
          ),
          8.spaceX,
          Expanded(
              child: Text(
            text,
            style: fsHeadLine6(fontWeight: FontWeight.w500, color: AppColors.red100),
          ))
        ],
      ),
    ],
  );
}

Widget errorWidget({required BuildContext context, required String errorState}) {
  return errorState.isNotEmpty
      ? Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.error_outlined,
                color: AppColors.red200,
                size: 16,
              ),
              Flexible(
                  child: Text(
                " $errorState",
                style: fsHeadLine6(context: context, color: AppColors.red200),
                maxLines: 2,
              )),
            ],
          ),
        )
      : SizedBox.shrink();
}

class AppButton extends StatelessWidget {
  final String text;
  final onTap;
  final bool enable;
  final Color? color;
  const AppButton({Key? key, required this.text, this.onTap, this.enable = true, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enable ? onTap : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: enable ? color ?? AppColors.primaryColor : Color(0XFFC7BF9D),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: enable
                  ? color != null
                      ? Colors.transparent
                      : AppColors.primaryColor
                  : Color(0XFFF9F9F7)),
        ),
        child: Center(
            child: Text(text,
                style: fsHeadLine5(
                    fontWeight: FontWeight.w500, color: enable ? AppColors.whiteColor1 : Color(0XFFF9F9F7)))),
      ),
    );
  }
}

class AppOutlineButton extends StatelessWidget {
  final String text;
  final onTap;
  final bool enable;
  final Color? color;
  const AppOutlineButton({Key? key, required this.text, this.onTap, this.enable = true, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enable ? onTap : () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color != null ? Colors.transparent : AppColors.primaryColor),
        ),
        child: Center(
          child: Text(
            text,
            style: fsHeadLine4(fontWeight: FontWeight.w500, color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}

class AppOptionButton extends StatelessWidget {
  final bool shrink;
  final String text;
  final onTap;
  final bool enable;
  const AppOptionButton({Key? key, required this.text, this.onTap, this.enable = true, this.shrink = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // onTap: enable ? onTap : () {},
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        width: shrink ? double.infinity : (MediaQuery.of(context).size.width * 0.3),
        padding: EdgeInsets.symmetric(vertical: shrink ? 14 : 20),
        decoration: BoxDecoration(
            color: AppColors.whiteColor1,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: !enable ? AppColors.gray200 : AppColors.blackShade1),
            boxShadow: !enable ? [] : [BoxShadow(color: Color(0XFFFFCC00), blurRadius: 0, offset: Offset(3, 3))]),
        child: Center(
            child: Text(text,
                style: shrink ? fsHeadLine6(fontWeight: FontWeight.w500) : fsHeadLine3(fontWeight: FontWeight.w600))),
      ),
    );
  }
}

InputDecoration appTextFildDecoration(String hint) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    hintText: hint,
    hintStyle: fsHeadLine5(color: AppColors.gray400, fontWeight: FontWeight.w500),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(width: 3),
    ),
  );
}

InputDecoration appMobileFieldDecoration(String hint) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    hintText: hint,
    prefix: Text(
      "+91",
      style: fsHeadLine5(color: AppColors.gray400, fontWeight: FontWeight.w500),
    ),
    hintStyle: fsHeadLine5(color: AppColors.gray400, fontWeight: FontWeight.w500),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(width: 3),
    ),
  );
}

TextStyle appInputLabel() {
  return fsHeadLine5(fontWeight: FontWeight.w500, letterSpacing: 1.1);
}
