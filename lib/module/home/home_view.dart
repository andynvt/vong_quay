import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CarouselController _controller;

  @override
  void initState() {
    _controller = CarouselController();
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
              Color(0xff36D1DC),
              Color(0xff5B86E5),
              // Colors.blue.withOpacity(0.2),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select wheel',
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Wheel name',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 250,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Center(
                    child: CarouselSlider(
                      items: [
                        Image.asset('assets/images/1.png'),
                        Image.asset('assets/images/2.png'),
                        Image.asset('assets/images/3.png'),
                        Image.asset('assets/images/4.png'),
                        Image.asset('assets/images/5.png'),
                      ],
                      carouselController: _controller,
                      options: CarouselOptions(
                        viewportFraction: 1,
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
                        onPressed: () {},
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Colors.white, width: 2),
                        ),
                        color: Colors.orange,
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
                        onPressed: () {},
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Colors.white, width: 2),
                        ),
                        color: Colors.orange,
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
            SizedBox(height: 30),
            SizedBox(
              width: 100,
              height: 100,
              child: FlatButton(
                onPressed: () {},
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: BorderSide(color: Colors.white, width: 5),
                ),
                color: Colors.green,
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 50,
              height: 50,
              child: FlatButton(
                onPressed: () {},
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: BorderSide(color: Colors.white, width: 2),
                ),
                color: Colors.orange,
                child: Icon(
                  Icons.volume_up,
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
