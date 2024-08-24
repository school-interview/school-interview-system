import 'package:flutter/material.dart';

class ImageNetworkManager extends StatelessWidget {
  const ImageNetworkManager(
      {super.key,
      required this.iconUrl,
      this.width,
      this.height,
      this.fit,
      this.isIgnoreExtension = false});

  final String iconUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool isIgnoreExtension;

  @override
  Widget build(BuildContext context) {
    final iconUrlRegExp = RegExp(r'^https://.*\.(jpeg|jpg|png)+$');
    return Container(
      child: iconUrl != '' &&
              (isIgnoreExtension || iconUrlRegExp.hasMatch(iconUrl))
          ? Image.network(iconUrl, width: width, height: height, fit: fit,
              errorBuilder: (context, object, stackTrace) {
              return Image.asset('assets/image/error.jpg');
            })
          : Image.asset('assets/image/error.jpg'),
    );
  }
}
