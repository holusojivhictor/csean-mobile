import 'package:csean_mobile/domain/enums/end_drawer_item_type.dart';
import 'package:csean_mobile/presentation/shared/utils/modal_bottom_sheet_utils.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: Styles.mainCardShape,
      margin: Styles.edgeInsetHorizontal16,
      color: Colors.grey.withOpacity(0.3),
      elevation: 0.0,
      child: Container(
        margin: Styles.edgeInsetAll5,
        padding: Styles.edgeInsetAll5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chapter change request',
                  style: theme.textTheme.bodyText1!.copyWith(fontSize: 15),
                ),
                const SizedBox(height: 3),
                Text(
                  'Make a request to switch from your current chapter.',
                  style: theme.textTheme.headline4,
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () => ModalBottomSheetUtils.showAppModalBottomSheet(context, EndDrawerItemType.chapterRequest),
                  child: Text(
                    'See details',
                    style: theme.textTheme.bodyText1!.copyWith(color: theme.primaryColor),
                  ),
                ),
              ],
            ),
            InkWell(
              borderRadius: Styles.mainCardBorderRadius,
              onTap: () => ModalBottomSheetUtils.showAppModalBottomSheet(context, EndDrawerItemType.chapterRequest),
              child: Container(
                margin: const EdgeInsets.all(5),
                child: const Icon(Icons.edit_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}