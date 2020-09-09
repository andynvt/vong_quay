import 'package:flutter/material.dart';
import 'package:vong_quay/config/wheel_item_config.dart';
import 'package:vong_quay/model/model.dart';
import 'package:vong_quay/service/cache/cache_service.dart';
import 'package:vong_quay/service/setting/setting_service.dart';

class DataService extends ChangeNotifier {
  static DataService _sInstance;
  final setting = SettingService();

  final List<WheelInfo> wheels = [];

  DataService._() {
    _initWheels();
  }

  factory DataService.shared() {
    if (_sInstance == null) {
      _sInstance = DataService._();
    }
    return _sInstance;
  }

  void _initWheels() {
    final firstWheel = CacheService.shared().getString('w|0|Giải trí|');
    if (firstWheel.isEmpty) {
      wheels.addAll([
        WheelInfo(id: 0, name: 'Giải trí', items: WheelItemConfig.giaiTriList),
        WheelInfo(id: 1, name: 'Sát phạt', items: WheelItemConfig.satPhatList),
        WheelInfo(id: 2, name: 'Sự thật hoặc Thử thách'),
        WheelInfo(id: 3, name: 'Tự nhập mức phạt'),
        WheelInfo(id: 4, name: 'Người được chọn'),
      ]);
      notifyListeners();
    }
  }

  void saveWheels() {
    // wheels.forEach((w) {
    //   CacheService.shared().setString('wheel', value)
    // });
  }
}
