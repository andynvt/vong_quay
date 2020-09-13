import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vong_quay/config/wheel_item_config.dart';
import 'package:vong_quay/model/model.dart';
import 'package:vong_quay/service/cache/cache_service.dart';
import 'package:vong_quay/service/setting/setting_service.dart';

class DataService extends ChangeNotifier {
  static DataService _sInstance;
  final setting = SettingService();

  final Map<String, WheelInfo> wheels = {};

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
    final cacheWheel = CacheService.shared().getString('wheel');
    if (cacheWheel.isEmpty) {
      wheels.addAll({
        '0': WheelInfo(image: _image(0), name: 'Giải trí', items: WheelItemConfig.giaiTriList),
        '1': WheelInfo(image: _image(1), name: 'Sát phạt', items: WheelItemConfig.satPhatList),
        '2': WheelInfo(image: _image(-2), name: 'Tự nhập', items: []),
      });
      // WheelInfo(id: 2, name: 'Sự thật hoặc Thử thách'),
      // WheelInfo(id: 3, name: 'Tự nhập mức phạt'),
      // WheelInfo(id: 4, name: 'Người được chọn'),
      notifyListeners();
    } else {
      final w = jsonDecode(cacheWheel);
      wheels.addAll(_wheelsFromJson(w));
      print(w);
    }
  }

  void addWheel(String name, List<ItemInfo> items, Function callback) {
    final last = wheels.remove((wheels.length - 1).toString());
    wheels[wheels.length.toString()] = WheelInfo(image: _image(-1), name: name, items: items);
    wheels[wheels.length.toString()] = last;
    _syncWheel();
    notifyListeners();
    callback();
  }

  void deleteWheel(String index) {
    int intIndex = int.parse(index);
    wheels.remove(index);

    final Map<String, WheelInfo> map = {};
    for(int i = 0; i<wheels.length; i++) {
      map['$i'] = wheels.values.toList()[i];
    }
    wheels.clear();
    wheels.addAll(map);

    _syncWheel();
    
    notifyListeners();
    CacheService.shared().setInt('index', 0);

  }

  Map<String, WheelInfo> _wheelsFromJson(Map<String, dynamic> map) {
    if (map == null || map.isEmpty) {
      return {};
    }
    final Map<String, WheelInfo> rs = {};
    map.forEach((key, value) {
      rs[key] = WheelInfo.fromJson(value);
    });
    return rs;
  }

  void _syncWheel() {
    final js = json.encode(wheels);
    CacheService.shared().setString('wheel', js);
  }

  String _image(int id) => 'assets/images/$id.png';
}
