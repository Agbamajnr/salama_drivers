import 'package:flutter/material.dart';

extension StringExtension on String {
  Color toColor() {
    final hexColor = toString();

    return Color(int.parse('0xff$hexColor'));
  }

  String get capitalize =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String get allInCaps => toUpperCase();
  String get allInLowerCase => toLowerCase();

  String get capitalizeFirstofEach =>
      split(' ').map((str) => str.capitalize).join(' ');

  String get svg => 'assets/svgs/$this.svg';
  String get png => 'assets/pngs/$this.png';
  String get gif => 'assets/gifs/$this.gif';

  String get escapeSpecial =>
      replaceAllMapped(RegExp(r'[.*+?^${}()|[\]\\]'), (x) {
        return '\\${x[0]}';
      });

  String get hideMiddleNumber =>
      '${substring(0, 3)}***** ${substring(length - 3, length)}';

  DateTime get dateParse {
    return DateTime.parse(this);
  }
}
