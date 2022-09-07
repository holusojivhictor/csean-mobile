import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:flutter/material.dart';

extension SupportStageTypeExtensions on SupportStageType {
  Color getBoxColor() {
    switch (this) {
      case SupportStageType.newItem:
        return Colors.orangeAccent.withOpacity(0.5);
      case SupportStageType.inProgress:
        return Colors.lightBlueAccent.withOpacity(0.5);
      case SupportStageType.resolved:
        return Colors.green.withOpacity(0.5);
      default:
        throw Exception('The provided stage type =$this is invalid');
    }
  }
}