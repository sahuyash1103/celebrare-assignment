import 'dart:io';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';

class ImageCropPage extends StatefulWidget {
  const ImageCropPage({super.key, required this.image});

  final File image;

  @override
  State<ImageCropPage> createState() => _ImageCropPageState();
}

class _ImageCropPageState extends State<ImageCropPage> {
  final cropController = CropController(
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );

  void rotateImg() {
    cropController.rotateRight();
  }

  void cropImage() async {
    final croppedImg = await cropController.croppedImage();
    if (!context.mounted) return;
    Navigator.pop(context, croppedImg);
  }

  void flipImg() {
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        const Rect.fromLTWH(0, 0, 100, 100),
        Offset.zero & const Size(40, 40),
      ),
      color: const Color(0xFF2e2e2e),
      items: [
        PopupMenuItem(
          child: ListTile(
            title: const Text(
              'Flip Horizontally',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            title: const Text(
              'Flip Vertically',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF222222),
          actions: [
            IconButton(
              onPressed: rotateImg,
              icon: const Icon(Icons.rotate_right_rounded, color: Colors.white),
            ),
            IconButton(
              onPressed: flipImg,
              icon: const Icon(Icons.flip, color: Colors.white),
            ),
            TextButton(
              onPressed: cropImage,
              child: const Text(
                'CROP',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2e2e2e),
        body: SafeArea(
          child: Center(
            child: CropImage(
              controller: cropController,
              image: Image.file(widget.image),
            ),
          ),
        ));
  }
}
