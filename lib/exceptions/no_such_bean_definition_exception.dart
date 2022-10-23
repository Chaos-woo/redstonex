class NoSuchBeanDefinitionException implements Exception {
  final String _msg;

  NoSuchBeanDefinitionException(this._msg);

  String get msg => _msg;
}
