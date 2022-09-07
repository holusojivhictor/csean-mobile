import 'package:flutter/material.dart';

double getTopHeightForPortrait(BuildContext context, bool isProfilePicture) {
  final factor = isProfilePicture ? 0.215 : 0.3;
  final value = MediaQuery.of(context).size.height * factor;

  if (value < 150) {
    return 150;
  }
  return value;
}

double getPaymentPageTopHeight(BuildContext context) {
  const factor = 0.29;
  final value = MediaQuery.of(context).size.height * factor;

  if (value < 250) {
    return 250;
  }
  return value;
}

double getTopMarginForPortrait(BuildContext context, bool isProfilePicture) {
  final maxTopHeight = (getTopHeightForPortrait(context, isProfilePicture)) - (isProfilePicture ? 5 : 20);
  return maxTopHeight;
}

const String loremIpsumText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";