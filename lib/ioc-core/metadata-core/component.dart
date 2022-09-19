import 'package:reflectable/reflectable.dart';

class Component extends Reflectable {
  const Component() : super(typingCapability, invokingCapability, reflectedTypeCapability);
}
