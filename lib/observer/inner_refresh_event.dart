import 'package:flutter/foundation.dart';

enum EventState { init, loading, success, fail }

class InnerRefreshEvent<T> {
  final EventState state;
  T? data;
  Exception? exception;
  Type? dataType;

  @mustCallSuper
  InnerRefreshEvent.init({
    this.data,
    this.exception,
  }) : state = EventState.init {
    if (null != data) {
      dataType = data.runtimeType;
    } else {
      dataType = null;
    }
  }

  @mustCallSuper
  InnerRefreshEvent.loading({
    this.data,
    this.exception,
  }) : state = EventState.loading {
    if (null != data) {
      dataType = data.runtimeType;
    } else {
      dataType = null;
    }
  }

  @mustCallSuper
  InnerRefreshEvent.success({
    this.data,
    this.exception,
  }) : state = EventState.success {
    if (null != data) {
      dataType = data.runtimeType;
    } else {
      dataType = null;
    }
  }

  @mustCallSuper
  InnerRefreshEvent.fail({
    this.data,
    this.exception,
  }) : state = EventState.fail {
    if (null != data) {
      dataType = data.runtimeType;
    } else {
      dataType = null;
    }
  }

  void refresh() {}
}

class InnerRefreshEvents<T> {
  final EventState state;
  List<T>? data;
  Exception? exception;
  Type? dataType;

  @mustCallSuper
  InnerRefreshEvents.init({
    this.data,
    this.exception,
  }) : state = EventState.init {
    if (null != data && data!.isNotEmpty) {
      dataType = data?.first.runtimeType;
    } else {
      dataType = null;
    }
  }

  @mustCallSuper
  InnerRefreshEvents.loading({
    this.data,
    this.exception,
  }) : state = EventState.loading {
    if (null != data && data!.isNotEmpty) {
      dataType = data?.first.runtimeType;
    } else {
      dataType = null;
    }
  }

  @mustCallSuper
  InnerRefreshEvents.success({
    this.data,
    this.exception,
  }) : state = EventState.success {
    if (null != data && data!.isNotEmpty) {
      dataType = data?.first.runtimeType;
    } else {
      dataType = null;
    }
  }

  @mustCallSuper
  InnerRefreshEvents.fail({
    this.data,
    this.exception,
  }) : state = EventState.fail {
    if (null != data && data!.isNotEmpty) {
      dataType = data?.first.runtimeType;
    } else {
      dataType = null;
    }
  }
}
