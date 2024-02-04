import 'dart:io';

import 'package:celebrare/pages/image_crop_page.dart';
import 'package:celebrare/widgets/custom_masked_image.dart';
import 'package:celebrare/widgets/mask_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Image? _image;
  String? _mask;

  void _addImage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 500,
      maxHeight: 500,
    );
    if (image == null || !context.mounted) return;

    Image? img = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ImageCropPage(image: File(image.path))));

    setState(() => _image = img);

    if (img == null || !context.mounted) return;

    final mask = await showDialog<String?>(
        context: context, builder: (context) => maskDialog(img));
    setState(() => _mask = mask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Image / Icon'),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[100],
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        leading: IconButton(
          onPressed: () => SystemNavigator.pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey[700],
            size: 30,
            weight: 600,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).colorScheme.primary,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 0.8,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(children: [
                Text(
                  'upload image',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addImage,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primary),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Choose from Device',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ]),
            ),
            if (_image != null) CustomMaskedImage(image: _image!, mask: _mask),
          ],
        ),
      ),
    );
  }
}
