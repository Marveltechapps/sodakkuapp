import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:video_player/video_player.dart';
import 'package:sodakkuapp/utils/constant.dart';

class ImageNetwork extends StatefulWidget {
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
  State<ImageNetwork> createState() => _ImageNetworkState();
}

class _ImageNetworkState extends State<ImageNetwork>
    with TickerProviderStateMixin {
  bool get isVideo => widget.url.toLowerCase().endsWith('.mp4');

  bool get isGif => widget.url.toLowerCase().endsWith('.gif');
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  late final _controllergif;
  @override
  void initState() {
    super.initState();
    isGif ? (_controllergif = GifController(vsync: this)) : debugPrint("");

    isVideo
        ? (_controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
            ..initialize()
                .then((_) {
                  setState(() {
                    _isInitialized = true;
                  });
                  _controller.setLooping(true);
                  _controller.play();
                })
                .catchError((_) {
                  setState(() => _isInitialized = false);
                }))
        : debugPrint("");
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isGif?_controllergif.dispose():debugPrint("");
    isVideo?_controller.dispose():debugPrint("");
  }

  @override
  Widget build(BuildContext context) {
    if (isVideo) {
      if (!_isInitialized) {
        return Image.asset(
          placeHolderImage,
          width: widget.width,
          height: widget.height,
        );
      }
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      );
    } else if (isGif) {
      return Gif(
        image: NetworkImage(widget.url),
        width: widget.width,
        height: widget.height,
        fit: BoxFit.cover,
        // errorWidget: (context, url, error) => Image.asset(placeHolderImage),
        placeholder: (context) => Image.asset(placeHolderImage),
        controller:
            _controllergif, // if duration and fps is null, original gif fps will be used.
        //fps: 30,
        //duration: const Duration(seconds: 3),
        autostart: Autostart.loop,
        onFetchCompleted: () {
          _controllergif.reset();
          _controllergif.forward();
        },
      );
    } else {
      return CachedNetworkImage(
        imageUrl: widget.url,
        height: widget.height,
        width: widget.width,
        fit: widget.fit ?? BoxFit.cover,
        placeholder: (context, url) => Image.asset(placeHolderImage),
        errorWidget: (context, url, error) => Image.asset(placeHolderImage),
      );
    }
  }
}
