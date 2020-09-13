import 'dart:ffi';

import 'package:vong_quay/model/item_info.dart';

class WheelInfo {
  String image;
  String name;
  List<ItemInfo> items = [];

  WheelInfo({this.image, this.name, this.items});

  factory WheelInfo.fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return WheelInfo(
      name: json['name'],
      image: json['image'],
      items: ItemInfo.fromList(json['items']),
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> items = this.items.map((e) => e.toJson()).toList();
    return {
      'image': this.image,
      'name': this.name,
      'items': items,
    };
  }
}
