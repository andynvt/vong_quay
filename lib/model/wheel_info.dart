import 'package:vong_quay/model/item_info.dart';

class WheelInfo {
  final int id;
  String name;
  List<ItemInfo> items = [];

  WheelInfo({this.id, this.name, this.items});
}
