import 'package:flutter/material.dart';
import 'package:widget_mask/widget_mask.dart';

class CustomMaskedImage extends StatelessWidget {
  const CustomMaskedImage({
    super.key,
    required this.image,
    required this.mask,
    this.width,
    this.height,
  });

  final Image image;
  final String? mask;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: width ?? MediaQuery.of(context).size.width,
      height: height,
      child: mask != null
          ? WidgetMask(
              mask: Image(
                image: image.image,
                width: width ?? MediaQuery.of(context).size.width,
                height: height,
                fit: BoxFit.cover,
              ),
              blendMode: BlendMode.srcATop,
              childSaveLayer: true,
              child: Image.asset(
                mask!,
                width: width ?? MediaQuery.of(context).size.width,
                height: height,
                fit: BoxFit.contain,
              ),
            )
          : Image(
              image: image.image,
              width: width ?? MediaQuery.of(context).size.width,
              height: height,
              fit: BoxFit.contain,
            ),
    );
  }
}
