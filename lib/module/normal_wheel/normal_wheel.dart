import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:vong_quay/config/config.dart';
import 'package:vong_quay/model/item_info.dart';
import 'package:vong_quay/service/audio_player/audio_player.dart';
import 'package:vong_quay/service/service.dart';
import 'package:vong_quay/widget/widget.dart';

class NormalWheel extends StatefulWidget {
  final List<ItemInfo> items;
  final WheelTypeEnum type;

  const NormalWheel({
    Key key,
    this.items,
    this.type = WheelTypeEnum.GIAI_TRI,
  }) : super(key: key);
  @override
  _NormalWheelState createState() => _NormalWheelState();
}

class _NormalWheelState extends State<NormalWheel> with SingleTickerProviderStateMixin {
  double _angle = 0;
  double _current = 0;
  AnimationController _ctrl;
  Animation _ani;
  bool _isHide = true;
  bool _isPlaying = false;

  void _start() {
    if(_isPlaying) {
      return;
    }
    _isPlaying = true;
    AudioPlayerService.shared().playSpin();
    if (!_ctrl.isAnimating) {
      setState(() {
        _isHide = true;
      });
      var _random = Random().nextDouble();
      _angle = 20 + Random().nextInt(5) + _random;
      _ctrl.forward(from: 0.0).then((_) {
        _current = (_current + _random);
        _current = _current - _current ~/ 1;
        _ctrl.reset();
      });
    }
  }

  @override
  void initState() {
    var _duration = Duration(milliseconds: 5000);
    _ctrl = AnimationController(vsync: this, duration: _duration);
    _ani = CurvedAnimation(parent: _ctrl, curve: Curves.fastLinearToSlowEaseIn);
    super.initState();

    _ani.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        AudioPlayerService.shared().playCongrats();
        setState(() {
          _isHide = false;
          _isPlaying = false;
        });
      }
    });
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
            bottom: 48,
            child: SafeArea(
              child: Container(
                width: 50,
                height: 50,
                child: FlatButton(
                  onPressed: () {
                    AudioPlayerService.shared().stop();
                    Navigator.of(context).pop();
                  },
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
            bottom: 48,
            child: SafeArea(
              child: SizedBox(
                width: 50,
                height: 50,
                child: Consum<SettingService>(
                  value: DataService.shared().setting,
                  builder: (_, service) {
                    return FlatButton(
                      onPressed: DataService.shared().setting.setMute,
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(color: Colors.white, width: 2),
                      ),
                      color: service.isMute ? Colors.grey : Colors.deepOrange[400],
                      child: Icon(
                        service.isMute ? Icons.volume_off : Icons.volume_up,
                        color: Colors.white,
                        size: 30,
                      ),
                    );
                  },
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
    final width = MediaQuery.of(context).size.width;
    if (_isHide) {
      return SizedBox(width: width, height: double.infinity);
    }
    return Align(
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          Container(
            height: 150,
            child: Center(
              child: SkeletonAnimation(
                child: Container(
                  height: 50,
                  width: width - 32,
                  color: widget.items[_index].color,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.items[_index].name.toUpperCase(),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'UTMSwissCondensed',
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Image.asset(widget.items[_index].image),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: width - 32,
              height: 200,
              child: !_isHide
                  ? FlareActor(
                      'assets/images/fireworks.flr',
                      animation: 'explode',
                    )
                  : SizedBox(),
            ),
          ),
        ],
      ),
    );
  }

  int _calIndex(value) {
    var _base = (2 * pi / widget.items.length / 2) / (2 * pi);
    return (((_base + value) % 1) * widget.items.length).floor();
  }
}
