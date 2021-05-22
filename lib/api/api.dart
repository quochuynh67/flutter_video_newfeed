import '../model/video.dart';

abstract class VideoNewFeedApi<V extends VideoInfo> {
  Future<List<V>> getListVideo();

  Future<List<V>> loadMore(List<V> currentList);
}
