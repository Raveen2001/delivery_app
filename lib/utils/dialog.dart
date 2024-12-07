import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

void openFullScreenImage(ImageProvider<Object> imageProvider) {
  Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      child: PhotoView(
        imageProvider: imageProvider,
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered,
      ),
    ),
  );
}
