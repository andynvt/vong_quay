import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:vong_quay/config/config.dart';
import 'package:vong_quay/model/model.dart';
import 'package:vong_quay/module/module.dart';
import 'package:vong_quay/widget/widget.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<WheelInfo> _wheels = [];
  CarouselController _controller;
  int _index = 0;
  bool _isMute = false;

  void _playClick() {
    switch (_index) {
      case 0:
        Navigator.of(context).push(
          createPage(NormalWheel(items: WheelItemConfig.giaiTriList)),
        );
        break;
      case 1:
        Navigator.of(context).push(
          createPage(NormalWheel(items: WheelItemConfig.satPhatList)),
        );
        break;
      case 2:
      case 3:
      case 4:
        break;
      default:
        break;
    }
  }

  void _soundClick() {
    setState(() {
      _isMute = !_isMute;
    });
  }

  @override
  void initState() {
    _controller = CarouselController();
    _wheels.addAll([
      WheelInfo(id: 0, name: 'Giải trí'),
      WheelInfo(id: 1, name: 'Sát phạt'),
      WheelInfo(id: 2, name: 'Sự thật hoặc Thử thách'),
      WheelInfo(id: 3, name: 'Tự nhập mức phạt'),
      WheelInfo(id: 4, name: 'Người được chọn'),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StrokeText(
              'Chọn vòng quay'.toUpperCase(),
              fontFamily: 'SFURhythmRegular',
              textAlign: TextAlign.center,
              color: Colors.deepOrange,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              strokeColor: Colors.white,
              strokeWidth: 0.8,
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: StrokeText(
                '${_wheels[_index].name}'.toUpperCase(),
                fontFamily: 'SFURhythmRegular',
                textAlign: TextAlign.center,
                color: Colors.white,
                fontSize: 33,
                fontWeight: FontWeight.bold,
                strokeColor: Colors.black,
                strokeWidth: 0.3,
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 250,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Center(
                    child: CarouselSlider.builder(
                      carouselController: _controller,
                      itemCount: _wheels.length,
                      itemBuilder: (_, index) {
                        return Image.asset(
                          'assets/images/${_wheels[index].id + 1}.png',
                        );
                      },
                      options: CarouselOptions(
                        viewportFraction: 1,
                        onPageChanged: (index, _) {
                          setState(() {
                            _index = index;
                          });
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 10,
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: FlatButton(
                        onPressed: () {
                          _controller.previousPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.linear,
                          );
                        },
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
                  Positioned(
                    top: 100,
                    right: 10,
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: FlatButton(
                        onPressed: () {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.linear,
                          );
                        },
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Colors.white, width: 2),
                        ),
                        color: Colors.deepOrange[400],
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: 90,
              height: 90,
              child: FlatButton(
                onPressed: _playClick,
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: BorderSide(color: Colors.white, width: 4),
                ),
                color: Colors.deepOrange,
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 65,
                ),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
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
          ],
        ),
      ),
    );
  }
}
