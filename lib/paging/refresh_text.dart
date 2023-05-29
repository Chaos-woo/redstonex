/// 刷新文案
class rRefreshTextCompose {
  late rRefreshHeaderText header;
  late rRefreshFooterText footer;

  rRefreshTextCompose({
    rRefreshHeaderText? header,
    rRefreshFooterText? footer,
  }) {
    this.header = header ?? rRefreshHeaderText();
    this.footer = footer ?? rRefreshFooterText();
  }
}

class rRefreshHeaderText {
  String idleText;
  String releaseText;
  String completeText;
  String refreshingText;

  rRefreshHeaderText({
    this.idleText = 'Pull to refresh',
    this.releaseText = 'Release to refresh',
    this.completeText = 'Refresh completed',
    this.refreshingText = 'Loading...',
  });
}

class rRefreshFooterText {
  String idleText;
  String canLoadingText;
  String loadingText;

  rRefreshFooterText({
    this.idleText = 'Load more',
    this.canLoadingText = 'Release to load',
    this.loadingText = 'Loading...',
  });
}
