import 'dart:io';

import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/presentation/profile_edit/widgets/picker_item.dart';
import 'package:csean_mobile/presentation/shared/custom_alert_dialog.dart';
import 'package:csean_mobile/presentation/shared/details/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class TopImage extends StatefulWidget {
  final String savedImage;
  final bool isPictureSet;
  final bool isEdit;

  const TopImage({
    Key? key,
    required this.savedImage,
    required this.isPictureSet,
    required this.isEdit,
  }) : super(key: key);

  @override
  State<TopImage> createState() => _TopImageState();
}

class _TopImageState extends State<TopImage> {
  late File largeImage;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    final maxHeight = getTopHeightForPortrait(context, true);

    return InkWell(
      onTap: widget.isEdit ? () => _pickImage(context) : null,
      child: Stack(
        children: [
          Opacity(
            opacity: widget.isEdit ? 0.7 : 1.0,
            child: SizedBox(
              height: maxHeight * 0.7,
              width: mediaQuery.size.width,
              child: widget.isPictureSet
                  ? Image.file(
                      widget.savedImage.isEmpty ? largeImage : File(widget.savedImage),
                      fit: BoxFit.fitWidth,
                      filterQuality: FilterQuality.high,
                    )
                  : DecoratedBox(
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withOpacity(0.7),
                      ),
                    ),
            ),
          ),
          if (widget.isEdit)
            SizedBox(
              height: maxHeight * 0.7,
              width: mediaQuery.size.width,
              child: const Center(
                child: Icon(Icons.camera_alt_outlined, size: 35, color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) => PickerAlertDialog(
        itemCount: 3,
        child: Column(
          children: [
            PickerItem(
              textString: 'Take photo',
              onTap: () {
                _sourceImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            PickerItem(
              textString: 'Choose existing photo',
              onTap: () {
                _sourceImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
            PickerItem(
              textString: 'Remove header',
              onTap: () {
                context.read<ProfileBloc>().add(const ProfileEvent.isHeaderSetChanged(newValue: false));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sourceImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final tempImage = await saveImagePath(image.path);
      largeImage = tempImage;
      setState(() {});
      context.read<ProfileBloc>().add(const ProfileEvent.isHeaderSetChanged(newValue: true));
    } on PlatformException catch (_) {}
  }

  Future<File> saveImagePath(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = path.basename(imagePath);
    final image = File('${directory.path}/$name');
    context.read<ProfileBloc>().add(ProfileEvent.headerImageChanged(newValue: image.path));

    return File(imagePath).copy(image.path);
  }
}
