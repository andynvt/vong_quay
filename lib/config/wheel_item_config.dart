import 'package:flutter/material.dart';
import 'package:vong_quay/model/model.dart';

class WheelItemConfig {
  WheelItemConfig._();

  static final List<ItemInfo> giaiTriList = [
    ItemInfo(name: "Qua tua", color: Colors.green, image: ""),
    ItemInfo(name: "Uống 200%", color: Colors.red, image: ""),
    ItemInfo(name: "Người bên phải uống", color: Colors.indigo, image: ""),
    ItemInfo(name: "Thêm lượt", color: Colors.orange, image: ""),
    ItemInfo(name: "Uống 50%", color: Colors.cyan, image: ""),
    ItemInfo(name: "Hát 1 bài rồi uống", color: Colors.lime, image: ""),
    ItemInfo(name: "Người bên trái uống", color: Colors.pink, image: ""),
    ItemInfo(name: "Uống với chí cốt", color: Colors.lightGreen, image: ""),
    ItemInfo(name: "Nhấp môi", color: Colors.amber, image: ""),
    ItemInfo(name: "Uống 100% + đổi vòng", color: Colors.blue, image: ""),
    ItemInfo(name: "Tất cả uống 100%", color: Colors.black, image: ""),
    ItemInfo(name: "Chỉ định người uống", color: Colors.deepPurple, image: ""),
  ];

  static final List<ItemInfo> satPhatList = [
    ItemInfo(name: "Thoát nạn", color: Colors.green, image: ""),
    ItemInfo(name: "Uống gấp đôi", color: Colors.red, image: ""),
    ItemInfo(name: "Mời 1 người uống", color: Colors.indigo, image: ""),
    ItemInfo(name: "Thêm lượt", color: Colors.orange, image: ""),
    ItemInfo(name: "Uống tuỳ ý", color: Colors.pink, image: ""),
    ItemInfo(name: "Hát 1 bài rồi uống", color: Colors.blue, image: ""),
    ItemInfo(name: "Đổi vòng", color: Colors.lightGreen, image: ""),
    ItemInfo(name: "Nhấp môi", color: Colors.cyan, image: ""),
  ];
}
