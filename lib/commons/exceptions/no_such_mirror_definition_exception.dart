
class NoSuchBeanDefinitionException implements Exception {
  final String message;

  NoSuchBeanDefinitionException(this.message) : super();
}