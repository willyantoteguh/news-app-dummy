import 'package:core/di/dependency.dart';
import 'package:home/di/dependency.dart';

class Injections {
  Future<void> initialize() async {
    await _registerSharedDependencies();
    _registerDomains();
  }

  void _registerDomains() {
    HomeDependency();
  }

  Future<void> _registerSharedDependencies() async {
    RegisterCoreModule();
  }
}
