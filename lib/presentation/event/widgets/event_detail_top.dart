import 'package:csean_mobile/presentation/shared/details/detail_top_layout.dart';
import 'package:flutter/material.dart';

class EventDetailTop extends StatelessWidget {
  final String image;
  const EventDetailTop({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailTopLayout(
      image: image,
      borderRadius: BorderRadius.zero,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leadingWidth: 40,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.grey.withOpacity(0.3),
              child: const Icon(Icons.keyboard_backspace_rounded, size: 20, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
