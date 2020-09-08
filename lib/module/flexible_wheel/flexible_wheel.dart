import 'package:flutter/material.dart';
import 'package:vong_quay/config/config.dart';
import 'package:vong_quay/model/model.dart';

class FlexibleWheel extends StatefulWidget {
  final List<ItemInfo> items;
  final WheelTypeEnum type;

  const FlexibleWheel({Key key, this.items, this.type}) : super(key: key);
  @override
  _FlexibleWheelState createState() => _FlexibleWheelState();
}

class _FlexibleWheelState extends State<FlexibleWheel> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
