import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/presentation/shared/bottom_sheets/custom_bottom_sheet.dart';
import 'package:csean_mobile/presentation/events/widgets/event_bottom_sheet.dart' as events;
import 'package:csean_mobile/presentation/profile/widgets/chapter_change_bottom_sheet.dart' as chapter_request;
import 'package:csean_mobile/presentation/progress_tracker/widgets/progress_tracker_bottom_sheet.dart' as progress_tracker;
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ModalBottomSheetUtils {
  static Widget getBottomSheetFromEndDrawerItemType(BuildContext context, EndDrawerItemType? type, {Map<String, dynamic>? args}) {
    switch (type) {
      case EndDrawerItemType.events:
        return const events.EventBottomSheet();
      case EndDrawerItemType.forums:
        return Container();
      case EndDrawerItemType.blogs:
        return Container();
      case EndDrawerItemType.chapterRequest:
        return const chapter_request.ChapterChangeBottomSheet();
      case EndDrawerItemType.progressTracker:
        return const progress_tracker.ProgressTrackerBottomSheet();
    }
    return Container();
  }

  static Future<void> showAppModalBottomSheet(BuildContext context, EndDrawerItemType type, {Map<String, dynamic>? args}) async {
    final size = MediaQuery.of(context).size;
    final device = getDeviceType(size);

    if (device == DeviceScreenType.mobile) {
      await showModalBottomSheet(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        context: context,
        shape: Styles.modalBottomSheetShape,
        isDismissible: true,
        isScrollControlled: true,
        builder: (ctx) => getBottomSheetFromEndDrawerItemType(context, type, args: args),
      );
      return;
    }

    await showCustomModalBottomSheet(
      context: context,
      builder: (ctx) => getBottomSheetFromEndDrawerItemType(context, type, args: args),
    );
  }
}