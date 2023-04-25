import 'package:flutter/foundation.dart';

enum EventState { init, loading, success, fail }

abstract class ListRefreshableEvent<T> {
  final EventState state;
  final List<T> data;
  Exception? exception;

  @mustCallSuper
  ListRefreshableEvent.init({
    required this.data,
    this.exception,
  }) : state = EventState.init;

  @mustCallSuper
  ListRefreshableEvent.loading({
    required this.data,
    this.exception,
  }) : state = EventState.loading;

  @mustCallSuper
  ListRefreshableEvent.success({
    required this.data,
    this.exception,
  }) : state = EventState.success;

  @mustCallSuper
  ListRefreshableEvent.fail({
    required this.data,
    this.exception,
  }) : state = EventState.fail;
}
