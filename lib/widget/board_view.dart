import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vong_quay/model/model.dart';

import 'arrow_view.dart';

class BoardView extends StatefulWidget {
  final double angle;
  final double current;
  final List<ItemInfo> items;

  const BoardView({Key key, this.angle, this.current, this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BoardViewState();
  }
}

class _BoardViewState extends State<BoardView> {
  Size get size => Size(
        MediaQuery.of(context).size.width * 0.9,
        MediaQuery.of(context).size.width * 0.9,
      );

  double _rotote(int index) => (index / widget.items.length) * 2 * pi;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        //shadow
        Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black38),
            ],
          ),
        ),
        Transform.rotate(
          angle: -(widget.current + widget.angle) * 2 * pi,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              for (var i in widget.items) ...[_buildCard(i)],
              for (var i in widget.items) ...[_buildImage(i)],
            ],
          ),
        ),
        Container(
          height: size.height,
          width: size.width,
          child: ArrowView(),
        ),
      ],
    );
  }

  _buildCard(ItemInfo item) {
    var _rotate = _rotote(widget.items.indexOf(item));
    var _angle = 2 * pi / widget.items.length;
    return Transform.rotate(
      angle: _rotate,
      child: ClipPath(
        clipper: _LuckPath(_angle),
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                item.color,
                item.color.withOpacity(0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildImage(ItemInfo item) {
    var _rotate = _rotote(widget.items.indexOf(item));
    var _angle = 2 * pi / widget.items.length;
    return Transform.rotate(
      angle: _rotate,
      child: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(
            height: size.height / 3,
            width: 50,
          ),
          child: Column(
            children: <Widget>[
              // Image.asset(luck.asset, width: 40,),
              SizedBox(height: 6),
              Container(
                width: double.infinity,
                // color: Colors.red,
                height: 70,
                child: AutoSizeText(
                  item.name.toUpperCase(),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'UTMSwissCondensed',
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Icon(
                Icons.gamepad,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LuckPath extends CustomClipper<Path> {
  final double angle;

  _LuckPath(this.angle);

  @override
  Path getClip(Size size) {
    Path _path = Path();
    Offset _center = size.center(Offset.zero);
    Rect _rect = Rect.fromCircle(center: _center, radius: size.width / 2);
    _path.moveTo(_center.dx, _center.dy);
    _path.arcTo(_rect, -pi / 2 - angle / 2, angle, false);
    _path.close();
    return _path;
  }

  @override
  bool shouldReclip(_LuckPath oldClipper) {
    return angle != oldClipper.angle;
  }
}
