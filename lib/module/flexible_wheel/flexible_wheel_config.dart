import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:vong_quay/model/model.dart';

class FlexibleWheelConfig extends StatefulWidget {
  @override
  _FlexibleWheelConfigState createState() => _FlexibleWheelConfigState();
}

class _FlexibleWheelConfigState extends State<FlexibleWheelConfig> {
  String _wheelName = '';
  int _quantity = 5;

  final Map<int, ItemInfo> items = {
    0: ItemInfo(color: Colors.green),
    1: ItemInfo(color: Colors.red),
    2: ItemInfo(color: Colors.indigo),
    3: ItemInfo(color: Colors.orange),
    4: ItemInfo(color: Colors.pink),
  };

  void _removeItemClick() {
    if (_quantity == 2) {
      return;
    }
    setState(() {
      _quantity -= 1;
    });
    items.remove(items.length);
  }

  void _addItemClick() {
    if (_quantity == 12) {
      return;
    }
    setState(() {
      _quantity += 1;
    });
    items[items.length] = ItemInfo(color: Colors.deepOrange);
  }

  void _selectColor(int index) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          content: MaterialColorPicker(
            shrinkWrap: true,
            selectedColor: items[index].color,
            onMainColorChange: (cl) {
              setState(() {
                items[index].color = cl;
              });
              Navigator.of(_).pop();
            },
            allowShades: false,
          ),
        );
      },
    );
  }

  void _doneClick() {
    print(_wheelName);
    print(items);
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
                  Color(0xff2193b0),
                  Color(0xff6dd5ed),
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SizedBox(height: 56),
                    SizedBox(
                      height: 45,
                      child: TextField(
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        maxLength: 20,
                        decoration: InputDecoration(
                          labelText: 'Tên vòng quay',
                          counterText: '',
                        ),
                        onChanged: (value) {
                          if (value != _wheelName) {
                            setState(() {
                              _wheelName = value;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'Số lượng ô',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: FlatButton(
                            onPressed: _removeItemClick,
                            padding: EdgeInsets.zero,
                            color: Colors.deepOrange[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                              side: BorderSide(color: Colors.white, width: 2),
                            ),
                            child: Icon(Icons.remove, color: Colors.white),
                          ),
                        ),
                        Container(
                          width: 20,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '$_quantity',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: FlatButton(
                            onPressed: _addItemClick,
                            padding: EdgeInsets.zero,
                            color: Colors.deepOrange[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                              side: BorderSide(color: Colors.white, width: 2),
                            ),
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: ListView.separated(
                        itemCount: _quantity,
                        separatorBuilder: (_, __) {
                          return SizedBox(height: 8);
                        },
                        itemBuilder: (_, index) {
                          return Container(
                            width: double.infinity,
                            child: Container(
                              margin: const EdgeInsets.only(top: 4),
                              height: 45,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                      cursorColor: Colors.white,
                                      maxLength: 20,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        labelText: 'Tên ô ${index + 1}',
                                      ),
                                      onChanged: (value) {
                                        items[index].name = value;
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  InkWell(
                                    onTap: () => _selectColor(index),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: items[index].color,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 2,
                                            offset: Offset(0, 1),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 8,
            child: SafeArea(
              child: Container(
                width: 40,
                height: 40,
                child: FlatButton(
                  onPressed: Navigator.of(context).pop,
                  padding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                  color: Colors.deepOrange,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: Icon(
                      Icons.trending_flat,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 8,
            child: SafeArea(
              child: Container(
                width: 40,
                height: 40,
                child: FlatButton(
                  onPressed: _doneClick,
                  padding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                  color: Colors.deepOrange,
                  child: Icon(
                    Icons.check,
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
}
