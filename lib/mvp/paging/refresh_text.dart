/// 刷新文案
class RefreshTextCompose {
  late RefreshHeaderText header;
  late RefreshFooterText footer;

  RefreshTextCompose({
    RefreshHeaderText? header,
    RefreshFooterText? footer,
  }) {
    this.header = header ?? RefreshHeaderText();
    this.footer = footer ?? RefreshFooterText();
  }
}

class RefreshHeaderText {
  String idleText;
  String releaseText;
  String completeText;
  String refreshingText;

  RefreshHeaderText({
    this.idleText = '下拉刷新',
    this.releaseText = '松开刷新',
    this.completeText = '刷新完成',
    this.refreshingText = '加载中...',
  });
}

class RefreshFooterText {
  String idleText;
  String canLoadingText;
  String loadingText;

  RefreshFooterText({
    this.idleText = '上拉加载更多',
    this.canLoadingText = '松开加载更多',
    this.loadingText = '加载中...',
  });
}
