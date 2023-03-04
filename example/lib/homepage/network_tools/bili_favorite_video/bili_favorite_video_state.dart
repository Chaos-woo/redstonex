import 'package:example/db-manager/entity/bili_favorite_video.dart';
import 'package:redstonex/redstonex.dart';

class BiliFavoriteVideoState {
  late BiliFavoriteVideoPagingState biliFavoriteVideoPagingState;

  BiliFavoriteVideoState() {
    ///Initialize variables
    biliFavoriteVideoPagingState = BiliFavoriteVideoPagingState();
  }
}

class BiliFavoriteVideoPagingState extends PagingState<BiliFavoriteVideo>{
  final int pageSize = 10;

  BiliFavoriteVideoPagingState() {
    ///Initialize variables
  }
}
