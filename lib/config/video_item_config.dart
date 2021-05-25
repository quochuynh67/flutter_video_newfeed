import 'package:flutter/widgets.dart';

class VideoItemConfig {
  /// In case: use to loop the video
  ///
  final bool loop;

  /// In case: auto play next video when current video is ended
  ///
  final bool autoPlayNextVideo;

  /// In case: use to change aspect ratio
  /// Default: video ratio
  ///
  final double? customAspectRatio;

  final Widget itemLoadingWidget;

  const VideoItemConfig({
    this.loop = true,
    this.autoPlayNextVideo = false,
    required this.itemLoadingWidget,
    this.customAspectRatio,
  });
}
