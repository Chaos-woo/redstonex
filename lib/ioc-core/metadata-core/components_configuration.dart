
import 'package:redstonex/ioc-core/metadata-core/component.dart';
import 'package:reflectable/reflectable.dart';

/// Put class's method return instance marked [Component]
/// to self-container when marking class metadata.
class ComponentsConfiguration extends Reflectable {
  const ComponentsConfiguration() : super(typingCapability, invokingCapability);
}