import 'package:example/services/models/bili_hot_video.dart';
import 'package:redstonex/redstonex.dart';

class BiliHotVideoState {
  late BiliHotVideoPagingState biliHotVideoPagingState;

  BiliHotVideoState() {
    ///Initialize variables
    biliHotVideoPagingState = BiliHotVideoPagingState();
  }
}

class BiliHotVideoPagingState extends rPagingState<BiliHotVideo>{
  final int pageSize = 10;

  BiliHotVideoPagingState() {
    ///Initialize variables
  }
}
