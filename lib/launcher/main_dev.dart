import 'package:common/utils/flavor/app_flavor.dart';
import 'package:flutter/material.dart';

import '../app/main_app.dart';
import '../injections/injections.dart';

void main() async {
  Config.appFlavor = Flavor.development;
  WidgetsFlutterBinding.ensureInitialized();
  await Injections().initialize();
  runApp(const NewsApp());
}
