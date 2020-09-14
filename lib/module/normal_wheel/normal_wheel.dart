import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:vong_quay/model/item_info.dart';
import 'package:vong_quay/service/audio_player/audio_player.dart';
import 'package:vong_quay/service/service.dart';
import 'package:vong_quay/widget/widget.dart';

class NormalWheel extends StatefulWidget {
  final String index;
  final List<ItemInfo> items;

  const NormalWheel({
    Key key,
    this.index,
    this.items,
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
  bool _hasDeleteButton = true;
  int _itemIndex = 0;

  void _start() {
    if (_isPlaying) {
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

  void _deleteClick() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Text(
            'Xoá vòng quay này?',
            style: const TextStyle(fontSize: 18),
          ),
          actions: [
            FlatButton(
              splashColor: Colors.orange[100],
              onPressed: Navigator.of(_).pop,
              child: Text(
                'Huỷ',
                style: const TextStyle(color: Colors.black),
              ),
            ),
            FlatButton(
              onPressed: () {
                DataService.shared().deleteWheel(widget.index);
                Navigator.of(_).pop();
                Navigator.of(context).pop();
              },
              splashColor: Colors.orange[100],
              child: Text(
                'Xoá',
                style: const TextStyle(color: Colors.deepOrange),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    FirebaseService.shared().logScreen('/home/normal-wheel');
    var _duration = Duration(milliseconds: 5000);
    _ctrl = AnimationController(vsync: this, duration: _duration);
    _ani = CurvedAnimation(parent: _ctrl, curve: Curves.fastLinearToSlowEaseIn);
    super.initState();

    _ani.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // AudioPlayerService.shared().playCongrats();
        AudioPlayerService.shared().playVoice(widget.index, _itemIndex);
        setState(() {
          _isHide = false;
          _isPlaying = false;
        });
      }
    });

    _hasDeleteButton = widget.index != '0' && widget.index != '1';
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
          Align(
            alignment: _hasDeleteButton ? Alignment.bottomCenter : Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(bottom: 48, right: _hasDeleteButton ? 0 : 16),
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
          ),
          _hasDeleteButton
              ? Positioned(
                  right: 16,
                  bottom: 48,
                  child: SafeArea(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: FlatButton(
                        onPressed: _deleteClick,
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: BorderSide(color: Colors.white, width: 2),
                        ),
                        color: Colors.deepOrange[400],
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
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
    _itemIndex = _calIndex(_value * _angle + _current);
    final width = MediaQuery.of(context).size.width;
    if (_isHide) {
      return SizedBox(width: width, height: double.infinity);
    }
    bool notHasAsset = widget.items[_itemIndex].image == null || widget.items[_itemIndex].image.isEmpty;
    return Align(
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          Container(
            height: 150,
            child: Center(
              child: SkeletonAnimation(
                child: Container(
                  height: notHasAsset ? 44 : 91,
                  width: width - 32,
                  color: widget.items[_itemIndex].color,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: () {
                    if (notHasAsset) {
                      return _renderText(_itemIndex);
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _renderText(_itemIndex),
                        SizedBox(height: 4),
                        Image.asset(
                          widget.items[_itemIndex].image,
                          width: 45,
                          height: 45,
                        ),
                      ],
                    );
                  }(),
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

  Widget _renderText(int _index) {
    return Text(
      widget.items[_index].name.toUpperCase(),
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'UTMSwissCondensed',
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  int _calIndex(value) {
    var _base = (2 * pi / widget.items.length / 2) / (2 * pi);
    return (((_base + value) % 1) * widget.items.length).floor();
  }
}
