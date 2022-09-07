import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/presentation/profile_edit/widgets/picker_item.dart';
import 'package:csean_mobile/domain/extensions/string_extensions.dart';
import 'package:csean_mobile/presentation/shared/custom_alert_dialog.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class BottomPositionedImage extends StatefulWidget {
  final bool isSmallNotNull;
  final String smallImage;
  final String demoImage;
  final bool update;
  final bool isEdit;

  const BottomPositionedImage({
    Key? key,
    required this.isSmallNotNull,
    required this.smallImage,
    required this.demoImage,
    required this.isEdit,
    required this.update,
  }) : super(key: key);

  @override
  State<BottomPositionedImage> createState() => _BottomPositionedImageState();
}

class _BottomPositionedImageState extends State<BottomPositionedImage> {
  late File pickedSmallImage = File("");

  @override
  void didUpdateWidget(BottomPositionedImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.update != oldWidget.update) {
      if (pickedSmallImage.path.isNotEmpty) {
        _submitUpdate(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: widget.isEdit ? () => _pickImage(context) : null,
      child: Container(
        height: 85,
        width: 85,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.scaffoldBackgroundColor,
          border: Border.all(color: theme.scaffoldBackgroundColor, width: 4),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (ctx, state) => state.map(
                loading: (_) => const Loading(useScaffold: false),
                loaded: (state) => Opacity(
                  opacity: widget.isEdit ? 0.7 : 1.0,
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: pickedSmallImage.path.isNullEmptyOrWhitespace
                        ? widget.isSmallNotNull && !state.useDemoProfilePicture
                            ? ClipOval(
                                child: Image(
                                  image: CachedNetworkImageProvider(widget.smallImage),
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                ),
                              )
                            : Image.asset(
                                widget.demoImage,
                                fit: BoxFit.contain,
                                filterQuality: FilterQuality.high,
                              )
                        : ClipOval(
                            child: Image.file(
                              pickedSmallImage,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            if (widget.isEdit)
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
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
              textString: 'Remove photo',
              onTap: () {
                _removeImage();
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

      final tempImage = File(image.path);
      pickedSmallImage = tempImage;
      context.read<SettingsBloc>().add(const SettingsEvent.useDemoProfilePictureChanged(newValue: false));
      setState(() {});
    } on PlatformException catch (_) {}
  }

  void _removeImage() {
    context.read<SettingsBloc>().add(const SettingsEvent.useDemoProfilePictureChanged(newValue: true));
    pickedSmallImage = File(" ");
    setState(() {});
  }

  Future<void> _submitUpdate(BuildContext context) async {
    context.read<DataBloc>().add(DataEvent.updateProfilePicture(image: pickedSmallImage));
  }
}
