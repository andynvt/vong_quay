import 'package:vong_quay/model/item_info.dart';

class WheelInfo {
  final int id;
  final String name;
  final List<ItemInfo> items = [];

  WheelInfo({this.id, this.name}) {}
}
