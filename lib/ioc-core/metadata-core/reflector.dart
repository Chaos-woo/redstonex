import 'package:reflectable/reflectable.dart';

/// Almost all capability meta `reflector` of Reflectable
///
/// All capacity reference: https://pub.dev/documentation/reflectable/latest/reflectable.capability/reflectable.capability-library.html
class Reflector extends Reflectable {
  const Reflector() : super(typingCapability, invokingCapability);
}

const reflector = Reflector();