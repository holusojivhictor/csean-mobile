import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:flutter/material.dart';

extension ChapterRequestStateExtensions on ChapterRequestState {
  Color getTextColor() {
    switch (this) {
      case ChapterRequestState.inactive:
        return const Color(0xFF015E1F);
      case ChapterRequestState.active:
        return const Color.fromARGB(255, 223, 165, 79);
      default:
        throw Exception('The provided request state =$this is invalid');
    }
  }
}