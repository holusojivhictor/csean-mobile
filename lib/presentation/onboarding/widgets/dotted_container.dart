import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DottedContainer extends StatelessWidget {
  final void Function()? onTap;
  final String fileName;
  final bool uploaded;
  final double height;
  final double? width;

  const DottedContainer({
    required this.onTap,
    this.fileName = '',
    this.uploaded = false,
    this.height = 100,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: DottedBorder(
        strokeWidth: 1,
        dashPattern: const [6, 2],
        borderType: BorderType.RRect,
        radius: const Radius.circular(5),
        child: Container(
          height: height,
          width: width ?? mediaQueryWidth * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.upload_rounded, size: 25, color: Colors.black.withOpacity(0.7)),
              const SizedBox(height: 5),
              Text(uploaded ? '$fileName uploaded.' : 'Browse files', style: Theme.of(context).textTheme.headline4!.copyWith(color: Theme.of(context).primaryColor)),
            ],
          ),
        ),
      ),
    );
  }
}