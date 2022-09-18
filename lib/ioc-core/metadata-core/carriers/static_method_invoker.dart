import 'package:redstonex/ioc-core/metadata-core/reflection.dart';
import 'package:redstonex/ioc-core/metadata-core/static_reflection.dart';
import 'package:redstonex/ioc-core/reflectable-core/mirror_initial_phase.dart';

/// Invoke any class's static method with [StaticReflection] or [Reflection]
///
class StaticMethodInvoker {
  final String methodName;
  final MirrorInitialPhase? phase; /// reach a phase, default is [MirrorInitialPhase.ultimate]
  final List? positionalArguments;
  final Map<Symbol, dynamic>? namedArguments;

  final List? Function()? positionalArgumentsSupplier;
  final Map<Symbol, dynamic>? Function()? namedArgumentsSupplier;

  const StaticMethodInvoker(
    this.methodName, {
    this.phase,
    this.positionalArguments,
    this.namedArguments,
    this.positionalArgumentsSupplier,
    this.namedArgumentsSupplier,
  });
}
