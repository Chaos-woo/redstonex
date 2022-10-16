import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/ioc-core/metadata-core/carriers/named_reference.dart';
import 'package:redstonex/ioc-core/metadata-core/component.dart';
import 'package:redstonex/ioc-core/metadata-core/components_configuration.dart';

@ComponentsConfiguration()
class DefGlobalConfigInitializer {

  /// Inject default global configuration.
  /// Using the same `tag` to initial [GlobalConfig] subclass
  /// and putting it to self application container(not GetX container),
  /// so self-ioc will override default configuration.
  @Component()
  @NamedReference(name: GlobalConfig.fixedGlobalConfigTag)
  GlobalConfig globalConfig() {
    return GlobalConfig();
  }
}
