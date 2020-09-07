import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vong_quay/model/item_info.dart';
import 'package:vong_quay/widget/widget.dart';

enum NormalWeelType { GIAI_TRI, SAT_PHAT }

class NormalWheel extends StatefulWidget {
  final List<ItemInfo> items;
  final NormalWeelType type;

  const NormalWheel({
    Key key,
    this.items,
    this.type = NormalWeelType.GIAI_TRI,
  }) : super(key: key);
  @override
  _NormalWheelState createState() => _NormalWheelState();
}

class _NormalWheelState extends State<NormalWheel> with SingleTickerProviderStateMixin {
  double _angle = 0;
  double _current = 0;
  AnimationController _ctrl;
  Animation _ani;

  @override
  void initState() {
    super.initState();
    var _duration = Duration(milliseconds: 10000);
    _ctrl = AnimationController(vsync: this, duration: _duration);
    _ani = CurvedAnimation(parent: _ctrl, curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff1c92d2),
        leading: SizedBox(
          width: 50,
          height: 50,
          child: FlatButton(
            onPressed: Navigator.of(context).pop,
            padding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.white, width: 2),
            ),
            color: Colors.deepOrange[400],
            child: Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff1c92d2),
              Color(0xfff2fcfe),
            ],
          ),
        ),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: _ani,
            builder: (_, __) {
              final _value = _ani.value;
              final _angle = _value * this._angle;
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  BoardView(items: widget.items, current: _current, angle: _angle),
                  _buildGo(),
                  _buildResult(_value),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildGo() {
    return Material(
      color: Colors.white,
      shape: CircleBorder(),
      child: InkWell(
        customBorder: CircleBorder(),
        child: Container(
          alignment: Alignment.center,
          height: 72,
          width: 72,
          child: Text(
            "QUAY",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        onTap: _animation,
      ),
    );
  }

  void _animation() {
    if (!_ctrl.isAnimating) {
      var _random = Random().nextDouble();
      _angle = 20 + Random().nextInt(5) + _random;
      _ctrl.forward(from: 0.0).then((_) {
        _current = (_current + _random);
        _current = _current - _current ~/ 1;
        _ctrl.reset();
      });
    }
  }

  int _calIndex(value) {
    var _base = (2 * pi / widget.items.length / 2) / (2 * pi);
    return (((_base + value) % 1) * widget.items.length).floor();
  }

  Widget _buildResult(_value) {
    var _index = _calIndex(_value * _angle + _current);
    // String _asset = widget.items[_index].asset;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(widget.items[_index].name),
      ),
    );
  }
}
