import 'package:reflectable/reflectable.dart';

/// Put class instance to self-container when marking
/// class metadata.
///
/// Otherwise, Put method return type instance to
/// self-container when marking method metadata
/// with class metadata [ComponentsConfiguration].
class Component extends Reflectable {
  const Component() : super(typingCapability, invokingCapability, reflectedTypeCapability);
}
