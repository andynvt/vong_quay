import 'package:flutter/material.dart';
import 'package:vong_quay/module/module.dart';
import 'package:vong_quay/service/service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheService.init();
  runApp(VongQuayApp());
}
