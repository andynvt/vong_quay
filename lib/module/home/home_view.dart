import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:vong_quay/config/config.dart';
import 'package:vong_quay/module/module.dart';
import 'package:vong_quay/service/service.dart';
import 'package:vong_quay/widget/widget.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CarouselController _controller;
  int _index = 0;

  void _playClick() {
    CacheService.shared().setInt('index', _index);
    switch (_index) {
      case 0:
        Navigator.of(context).push(createPage(NormalWheel(items: WheelItemConfig.giaiTriList)));
        break;
      case 1:
        Navigator.of(context).push(createPage(NormalWheel(items: WheelItemConfig.satPhatList)));
        break;
      case 2:
      case 3:
        Navigator.of(context).push(createPage(FlexibleWheelConfig()));
        break;
      case 4:
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    _index = CacheService.shared().getInt('index');
    _controller = CarouselController();
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      _controller.jumpToPage(_index);
    });
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
              fontSize: 35,
              fontWeight: FontWeight.bold,
              strokeColor: Colors.white,
              strokeWidth: 0.8,
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Consum<DataService>(
                value: DataService.shared(),
                builder: (_, service) {
                  return StrokeText(
                    '${service.wheels[_index].name}'.toUpperCase(),
                    fontFamily: 'SFURhythmRegular',
                    textAlign: TextAlign.center,
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    strokeColor: Colors.black,
                    strokeWidth: 0.3,
                  );
                },
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 250,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Center(
                    child: Consum<DataService>(
                      value: DataService.shared(),
                      builder: (_, service) {
                        return CarouselSlider.builder(
                          carouselController: _controller,
                          itemCount: service.wheels.length,
                          itemBuilder: (_, index) {
                            return Image.asset(
                              'assets/images/${service.wheels[index].id + 1}.png',
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
                        );
                      },
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
                          borderRadius: BorderRadius.circular(100),
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
                          borderRadius: BorderRadius.circular(100),
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
            SizedBox(height: 4),
            Consum<DataService>(
              value: DataService.shared(),
              builder: (_, service) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: service.wheels.map((url) {
                    int index = service.wheels.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _index == index ? Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            SizedBox(height: 16),
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
          ],
        ),
      ),
    );
  }
}
