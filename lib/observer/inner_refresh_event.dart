enum EventState { init, loading, success, fail }

class InnerRefreshEvent<T> {
  final EventState state;
  T? data;
  Exception? exception;
  Type? dataType;

  InnerRefreshEvent.init({
    this.data,
    this.exception,
  }) : state = EventState.init;

  InnerRefreshEvent.loading({
    this.data,
    this.exception,
  }) : state = EventState.loading;

  InnerRefreshEvent.success({
    this.data,
    this.exception,
  }) : state = EventState.success;

  InnerRefreshEvent.fail({
    this.data,
    this.exception,
  }) : state = EventState.fail;

  void refresh() {
    if (null != data) {
      dataType = data.runtimeType;
    } else {
      dataType = null;
    }
  }
}

class InnerRefreshEvents<T> {
  final EventState state;
  List<T>? data;
  Exception? exception;
  Type? dataType;

  InnerRefreshEvents.init({
    this.data,
    this.exception,
  }) : state = EventState.init;

  InnerRefreshEvents.loading({
    this.data,
    this.exception,
  }) : state = EventState.loading;

  InnerRefreshEvents.success({
    this.data,
    this.exception,
  }) : state = EventState.success;

  InnerRefreshEvents.fail({
    this.data,
    this.exception,
  }) : state = EventState.fail;

  void refresh() {
    if (null != data && data!.isNotEmpty) {
      dataType = data?.first.runtimeType;
    } else {
      dataType = null;
    }
  }
}

