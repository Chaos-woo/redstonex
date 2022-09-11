
import 'package:reflectable/reflectable.dart';

class Autowired extends Reflectable {
  const Autowired() : super(typingCapability, invokingCapability, reflectedTypeCapability);
}