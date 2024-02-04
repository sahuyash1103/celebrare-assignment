import 'package:celebrare/widgets/custom_masked_image.dart';
import 'package:flutter/material.dart';

Widget maskDialog(Image image) {
  final List<String> allMasks = [
    'assets/images/heart_mask.png',
    'assets/images/circle_mask.png',
    'assets/images/square_mask.png',
    'assets/images/rectangle_mask.png',
  ];

  String? maskStr;

  return Dialog(
    child: StatefulBuilder(builder: (context, setState) {
      void setMask(String? m) => WidgetsBinding.instance
          .addPostFrameCallback((_) => setState(() => maskStr = m));
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          Text('Upload Image',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 20)),
          SizedBox(
            width: 300,
            height: 300,
            child: CustomMaskedImage(image: image, mask: maskStr),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => setMask(null),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.grey,
                        width: 0.8,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  elevation: MaterialStateProperty.all<double>(0),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(5),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(40, 40),
                  ),
                ),
                child: const Text(
                  'Original',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
              for (var mask in allMasks)
                ElevatedButton(
                  onPressed: () => setMask(mask),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 0.8,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    elevation: MaterialStateProperty.all<double>(0),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.all(5),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(40, 40),
                    ),
                  ),
                  child: Image.asset(mask, width: 35, height: 35),
                ),
            ],
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, maskStr),
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
              'Use this image',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      );
    }),
  );
}
