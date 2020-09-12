import 'package:flutter/material.dart';
import 'package:vong_quay/model/model.dart';

class WheelItemConfig {
  WheelItemConfig._();
  static String _image(int id) {
    return 'assets/images/ic_wi_$id.png';
  }

  static final List<ItemInfo> giaiTriList = [
    ItemInfo(name: "Thêm lượt", color: Colors.green, image: _image(4)),
    ItemInfo(name: "Uống gấp đôi", color: Colors.red, image: _image(2)),
    ItemInfo(name: "Qua tua", color: Colors.indigo, image: _image(1)),
    ItemInfo(name: "Nam uống nữ vỗ tay", color: Colors.orange, image: _image(13)),
    ItemInfo(name: "Uống tuỳ ý", color: Colors.pink, image: _image(9)),
    ItemInfo(name: "Nữ uống nam vỗ tay", color: Colors.blue, image: _image(13)),
    ItemInfo(name: "Uống với chiến hữu", color: Colors.lightGreen, image: _image(8)),
    ItemInfo(name: "Phần thưởng", color: Colors.cyan, image: _image(14)),
    ItemInfo(name: "Chỉ định 1 người uống", color: Colors.black, image: _image(12)),
    ItemInfo(name: "Đứng nghiêm + uống 1 ly", color: Colors.purple, image: _image(15)),
    ItemInfo(name: "Tất cả nâng ly", color: Colors.amber, image: _image(11)),
    ItemInfo(name: "Chỉ định 2 người uống", color: Colors.teal, image: _image(12)),
  ];

  static final List<ItemInfo> satPhatList = [
    ItemInfo(name: "Thoát nạn", color: Colors.green, image: _image(1)),
    ItemInfo(name: "Uống 200%", color: Colors.red, image: _image(2)),
    ItemInfo(name: "Người bên phải uống", color: Colors.indigo, image: _image(3)),
    ItemInfo(name: "Thêm lượt", color: Colors.orange, image: _image(4)),
    ItemInfo(name: "Uống 50%", color: Colors.cyan, image: _image(5)),
    ItemInfo(name: "Hát 1 bài rồi uống", color: Colors.lime, image: _image(6)),
    ItemInfo(name: "Người bên trái uống", color: Colors.pink, image: _image(7)),
    ItemInfo(name: "Uống với chí cốt", color: Colors.lightGreen, image: _image(8)),
    ItemInfo(name: "Nhấp môi", color: Colors.blue, image: _image(9)),
    ItemInfo(name: "Uống 100% + đổi vòng", color: Colors.amber, image: _image(10)),
    ItemInfo(name: "Tất cả uống 100%", color: Colors.black, image: _image(11)),
    ItemInfo(name: "Chỉ định người uống", color: Colors.deepPurple, image: _image(12)),
  ];
}
