import 'package:flutter/material.dart';
import 'package:flutter_video_newfeed/config/video_item_config.dart';
import 'package:flutter_video_newfeed/model/video.dart';
import 'package:video_player/video_player.dart';

import 'built_in/default_video_info.dart';

class VideoItemWidget<V extends VideoInfo> extends StatefulWidget {
  final int pageIndex;
  final int currentPageIndex;
  final bool isPaused;

  /// Video ended callback
  ///
  final void Function() videoEnded;

  final VideoItemConfig config;

  /// Video Information: like count, like, more, name song, ....
  ///
  final VideoInfo videoInfo;

//  /// Video network url
//  ///
//  final String url;

  /// Video Info Customizable
  ///
  final Widget Function(BuildContext context, V v) customVideoInfoWidget;

  VideoItemWidget(
      {

      /// video information
      this.videoInfo,

      /// video config
      this.config = const VideoItemConfig(
          loop: true,
          itemLoadingWidget: CircularProgressIndicator(),
          autoPlayNextVideo: true),
      this.pageIndex,
      this.currentPageIndex,
      this.isPaused,
      this.customVideoInfoWidget,
      this.videoEnded})
      : assert(videoInfo != null && videoInfo.url != null);

  @override
  State<StatefulWidget> createState() => _VideoItemWidgetState<V>();
}

class _VideoItemWidgetState<V extends VideoInfo>
    extends State<VideoItemWidget<V>> {
  VideoPlayerController _videoPlayerController;
  bool initialized = false;
  bool actualDisposed = false;
  bool isEnded = false;

  ///
  ///
  @override
  void initState() {
    super.initState();
    _initVideoController();
  }

  ///
  ///
  @override
  Widget build(BuildContext context) {
    _pauseAndPlayVideo();
    return Center(
      child: Stack(
        children: [
          initialized ? _renderVideo() : Container(),
          _renderVideoInfo(),
        ],
      ),
    );
  }

  ///
  ///
  @override
  void dispose() {
    if (_videoPlayerController != null) {
      _videoPlayerController.removeListener(_videoListener);
      _videoPlayerController.dispose();
      _videoPlayerController = null;
    }

    actualDisposed = true;
    super.dispose();
  }

  /// Video initialization
  ///
  void _initVideoController() {
    // Init video from network url
    _videoPlayerController =
        VideoPlayerController.network(widget.videoInfo.url);
    _videoPlayerController.addListener(_videoListener);
    _videoPlayerController.initialize().then((_) {
      setState(() {
        _videoPlayerController.setLooping(widget.config.loop);
        initialized = true;
      });
    });
  }

  /// Video controller listener
  ///
  void _videoListener() {
    if (_videoPlayerController.value.position != null &&
        _videoPlayerController.value.duration != null) {
      /// check if video has ended
      ///
      if (_videoPlayerController.value.position >=
          _videoPlayerController.value.duration) {
        if (widget.config.autoPlayNextVideo &&
            widget.videoEnded != null &&
            !isEnded) {
          isEnded = true;
          widget.videoEnded();
        }
      }
    }
  }

  void _pauseAndPlayVideo() {
    if (_videoPlayerController != null) {
      if (widget.pageIndex == widget.currentPageIndex &&
          !widget.isPaused &&
          initialized) {
        _videoPlayerController.play().then((value) {});
      } else {
        _videoPlayerController.pause().then((value) {});
      }
    }
  }

  Widget _renderVideo() {
    return Center(
      child: AspectRatio(
        aspectRatio: widget.config.customAspectRatio ??
            _videoPlayerController.value.aspectRatio,
        child: VideoPlayer(_videoPlayerController),
      ),
    );
  }

  Widget _renderVideoInfo() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      width: w,
      height: h,
      child: widget.customVideoInfoWidget != null
          ? widget.customVideoInfoWidget(context, widget.videoInfo)
          : DefaultVideoInfoWidget(),
    );
  }
}
