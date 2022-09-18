import 'package:reflectable/reflectable.dart';

class StaticReflection extends Reflectable {
  const StaticReflection() : super(typingCapability, invokingCapability, reflectedTypeCapability);
}
