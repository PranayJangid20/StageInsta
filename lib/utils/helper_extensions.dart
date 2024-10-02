import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


extension DebugPrint on Object? {
  void log() => debugPrint('\x1B[33m${toString()}\x1B[0m');
}

extension NullOrEmptyCheck on String? {
  bool get isNull => this == null;
  bool get isNuUOrEmpty => isNull || this!.isEmpty;
}

extension SpaceXY on num {
  SizedBox get spaceX => SizedBox(width: toDouble());
  SizedBox get spaceY => SizedBox(height: toDouble());
}

extension GetNumber on String {
  int get getNumber => int.tryParse(trim().replaceAll(RegExp(r'\D+'), '')) ?? 0;
}

extension GetDate on int {
  String get toDate => DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(this));
}

extension GetNamedDate on int {
  String get toNamedDate => DateFormat('dd-MMM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(this));
}

extension GetTime on int {
  String get toTime => DateFormat('hh-mm').format(DateTime.fromMillisecondsSinceEpoch(this));
}
extension GetTimeSec on int {
  String get toTimeSec => DateFormat('hh-mm-ss').format(DateTime.fromMillisecondsSinceEpoch(this));
}
extension MillisecondsSinceEpochToMonths on int {
  int toMonthsSinceEpoch() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this);
    return (dateTime.year - 1970) * 12 + dateTime.month - 1;
  }
}

timeFromMongo(String time){
  DateTime updatedAt = DateTime.parse(time).toLocal();
  DateTime now = DateTime.now();

  String formattedTime;

  if (now.difference(updatedAt).inDays == 0) {
    // If it's today, format it as "Today hh:mm a"
    formattedTime = DateFormat.jm().format(updatedAt); // "5:23 PM"
  } else if (now.year == updatedAt.year) {
    // If it's in the same year, format it as "Last Edit - d MMM yyyy"
    formattedTime = '${DateFormat('d MMM yyyy').format(updatedAt)}';
  } else {
    // If it's in a different year, format it as "d MMM yyyy"
    formattedTime = DateFormat('d MMM yyyy').format(updatedAt);
  }
  return formattedTime;
}

extension GetTimeFromMongo on String{

  String get fromMongoDate => timeFromMongo(this);
}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}