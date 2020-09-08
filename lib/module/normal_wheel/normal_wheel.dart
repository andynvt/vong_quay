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
  bool _isMute = false;

  void _start() {
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

  void _soundClick() {
    setState(() {
      _isMute = !_isMute;
    });
  }

  @override
  void initState() {
    super.initState();
    var _duration = Duration(milliseconds: 5000);
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff9CECFB),
                  Color(0xff65C7F7),
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
                      BoardView(
                        items: widget.items,
                        current: _current,
                        angle: _angle,
                      ),
                      _buildGo(),
                      _buildResult(_value),
                    ],
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: SafeArea(
              child: Container(
                width: 50,
                height: 50,
                child: FlatButton(
                  onPressed: Navigator.of(context).pop,
                  padding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                  color: Colors.deepOrange[400],
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: Icon(
                      Icons.trending_flat,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: SafeArea(
              child: SizedBox(
                width: 50,
                height: 50,
                child: FlatButton(
                  onPressed: _soundClick,
                  padding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                  color: _isMute ? Colors.grey : Colors.deepOrange[400],
                  child: Icon(
                    _isMute ? Icons.volume_off : Icons.volume_up,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGo() {
    return Container(
      width: 72,
      height: 72,
      child: FlatButton(
        onPressed: _start,
        padding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(color: Colors.white, width: 2),
        ),
        color: Colors.deepOrange[400],
        child: Text(
          "QUAY",
          style: TextStyle(
            fontFamily: 'SFURhythmRegular',
            fontSize: 23,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildResult(_value) {
    var _index = _calIndex(_value * _angle + _current);
    // String _asset = widget.items[_index].asset;
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Text(widget.items[_index].name),
      ),
    );
  }

  int _calIndex(value) {
    var _base = (2 * pi / widget.items.length / 2) / (2 * pi);
    return (((_base + value) % 1) * widget.items.length).floor();
  }
}
