import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sodakkuapp/utils/constant.dart';

class ImageNetwork extends StatelessWidget {
  final String url;
  final BoxFit? fit;
  final double? height;
  final double? width;
  const ImageNetwork({
    super.key,
    required this.url,
    this.fit,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: fit,
      placeholder: (context, url) => Image.asset(placeHolderImage),
      errorWidget: (context, url, error) => Image.asset(placeHolderImage),
    );
  }
}
