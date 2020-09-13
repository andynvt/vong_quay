import 'dart:ui';
import 'package:flutter/material.dart';

class ItemInfo {
  String name;
  String image;
  Color color;

  ItemInfo({this.name = '', this.image = '', this.color = Colors.black});

  factory ItemInfo.fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    return ItemInfo(
      name: json['name'],
      image: json['image'],
      color: Color(json['color']),
    );
  }

  static List<ItemInfo> fromList(List<dynamic> ls) {
    if (ls == null || ls.isEmpty) {
      return [];
    }

    return ls.map((e) => ItemInfo.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'image': this.image,
      'color': this.color.value,
    };
  }
}
