import 'dart:io';

import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/extensions/string_extensions.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/domain/services/csean_service.dart';
import 'package:csean_mobile/injection.dart';
import 'package:csean_mobile/presentation/shared/custom_card.dart';
import 'package:csean_mobile/presentation/shared/utils/toast_utils.dart';
import 'package:csean_mobile/theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResourceCard extends StatefulWidget {
  final int id;
  final String title;
  final ResourceType type;
  final String description;
  final String createdAt;
  final String fileUrl;
  final bool isDownloaded;
  final int categoryId;
  final int subCategoryId;

  final double imgWidth;
  final double imgHeight;
  final bool withElevation;

  const ResourceCard({
    Key? key,
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.createdAt,
    required this.fileUrl,
    required this.isDownloaded,
    required this.categoryId,
    required this.subCategoryId,
    this.imgWidth = 50,
    this.imgHeight = 50,
    this.withElevation = true,
  }) : super(key: key);

  ResourceCard.item({
    Key? key,
    required ResourceItemCardModel resource,
    this.imgWidth = 45,
    this.imgHeight = 45,
    this.withElevation = true,
  })  : id = resource.id,
        title = resource.title,
        type = resource.type,
        description = resource.description,
        createdAt = resource.createdAt,
        fileUrl = resource.fileUrl,
        isDownloaded = resource.isDownloaded,
        categoryId = resource.categoryId,
        subCategoryId = resource.subCategoryId,
        super(key: key);

  @override
  State<ResourceCard> createState() => _ResourceCardState();
}

class _ResourceCardState extends State<ResourceCard> {
  late int fileSize = 1024;
  String progress = "";
  bool isDownloaded = false;
  bool isDownloading = false;

  @override
  void initState() {
    super.initState();
    getSavedInt(key: widget.fileUrl.split('/').last).then((value) {
      setState(() {
        fileSize = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomCard(
      clipBehavior: Clip.hardEdge,
      margin: Styles.edgeInsetHorizontal10Vertical5,
      shape: Styles.mainCardShape,
      elevation: widget.withElevation ? Styles.cardTenElevation : 0,
      color: Colors.grey.withOpacity(0.25),
      child: Padding(
        padding: Styles.edgeInsetHorizontal10Vertical5,
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: Image(
                height: widget.imgHeight,
                width: widget.imgWidth,
                image: AssetImage(Assets.getResourceTypeImage(widget.type, widget.fileUrl.split('.').last)),
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 70,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: theme.textTheme.headline2!.copyWith(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: theme.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w200),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              getFileSizeString(bytes: fileSize),
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyText2!.copyWith(color: Colors.black45, fontWeight: FontWeight.w600),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: CircleAvatar(
                                radius: 2,
                                backgroundColor: Colors.black45,
                              ),
                            ),
                            Text(
                              widget.createdAt.formatDateString(hasYear: true),
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyText2!.copyWith(color: Colors.black45, fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: widget.fileUrl.isNullEmptyOrWhitespace ? const SizedBox.shrink() : widget.isDownloaded
                  ? const Icon(Icons.done)
                  : isDownloading
                      ? CircularPercentIndicator(
                          radius: 20,
                          percent: double.parse(progress) / 100,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.black.withOpacity(0.7),
                        )
                      : IconButton(
                          splashRadius: 25,
                          icon: Icon(Icons.file_download, color: Colors.black.withOpacity(0.7)),
                          onPressed: () => _download(context),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _download(BuildContext context) async {
    final fToast = ToastUtils.of(context);
    final cseanService = getIt<CseanService>();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final downloadedIds = await getSavedStringList(key: 'Resources-Downloaded');
    final Dio dio = Dio();

    try {
      if (!await Permission.storage.request().isGranted) {
        ToastUtils.showInfoToast(fToast, 'You need to accept the requested permission to be able to download');
        return;
      }
      ToastUtils.showInfoToast(fToast, 'Downloading...');
      final parsed = '${widget.title.trim()}.${widget.fileUrl.split('.').last}';
      String savePath = await _getFilePath(parsed);

      try {
        await dio.download(
          widget.fileUrl,
          savePath,
          onReceiveProgress: (received, total) {
            setState(() {
              isDownloading = true;
              progress = ((received / total) * 100).toStringAsFixed(0);
            });
          },
          deleteOnError: true,
        ).then((_) {
          setState(() {
            if (progress == '100') {
              isDownloaded = true;
              isDownloading = false;
              prefs.setStringList('Resources-Downloaded', [...downloadedIds, '${widget.id}']);
              ToastUtils.showSucceedToast(fToast, 'Document was successfully saved to your storage');
              cseanService.getDownloaded();
              final bloc = context.read<ResourceBloc>();
              bloc.add(ResourceEvent.loadFromIds(categoryId: widget.categoryId, subCategoryId: widget.subCategoryId));
            }
          });
        });
      } on DioError catch (e) {
        ToastUtils.showErrorToast(fToast, 'Unknown error occurred');
      }
    } catch (e) {
      ToastUtils.showErrorToast(fToast, 'Unknown error occurred');
    }
  }

  Future<String> _getFilePath(String name) async {
    String path = '';

    Directory dir = Directory('/storage/emulated/0/Download');
    path = '${dir.path}/$name';

    return path;
  }
}
