import 'dart:async';
import 'package:flutter/material.dart';

class SpecialOffersScreen extends StatefulWidget {
  @override
  _SpecialOffersScreenState createState() => _SpecialOffersScreenState();
}

class _SpecialOffersScreenState extends State<SpecialOffersScreen> {
  final List<String> _topBanners = [
    'assets/images/service/offer2.jpg',
    'assets/images/service/offer3.jpg',
    'assets/images/service/third.jpg',
    'assets/images/service/offer1.jpg',
    'assets/images/service/offer4.jpg',
  ];

  final List<String> _bottomBanners = [
    'assets/images/service/offer5.jpg',
    'assets/images/service/offer6.jpg',
    'assets/images/service/offer7.jpg',
    'assets/images/service/offer8.jpg',
  ];

  final List<String> _middleBanners1 = [
    'assets/images/service/offer1.jpg',
    'assets/images/service/offer4.jpg',
    'assets/images/service/offer5.jpg',
  ];

  final List<String> _middleBanners2 = [
    'assets/images/service/offer8.jpg',
    'assets/images/service/offer6.jpg',
    'assets/images/service/offer7.jpg',
  ];

  PageController _topPageController = PageController();
  PageController _bottomPageController = PageController();
  PageController _middlePageController1 = PageController();
  PageController _middlePageController2 = PageController();

  int _topCurrentIndex = 0;
  int _bottomCurrentIndex = 0;
  int _middleCurrentIndex1 = 0;
  int _middleCurrentIndex2 = 0;

  Timer? _topTimer;
  Timer? _bottomTimer;
  Timer? _middleTimer1;
  Timer? _middleTimer2;

  @override
  void initState() {
    super.initState();
    _startTopAutoSlide();
    _startBottomAutoSlide();
    _startMiddleAutoSlide1();
    _startMiddleAutoSlide2();
  }

  @override
  void dispose() {
    _topTimer?.cancel();
    _bottomTimer?.cancel();
    _middleTimer1?.cancel();
    _middleTimer2?.cancel();
    super.dispose();
  }

  void _startTopAutoSlide() {
    _topTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_topCurrentIndex < _topBanners.length - 1) {
        _topCurrentIndex++;
      } else {
        _topCurrentIndex = 0;
      }
      _topPageController.animateToPage(
        _topCurrentIndex,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  void _startBottomAutoSlide() {
    _bottomTimer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_bottomCurrentIndex < _bottomBanners.length - 1) {
        _bottomCurrentIndex++;
      } else {
        _bottomCurrentIndex = 0;
      }
      _bottomPageController.animateToPage(
        _bottomCurrentIndex,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  void _startMiddleAutoSlide1() {
    _middleTimer1 = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_middleCurrentIndex1 < _middleBanners1.length - 1) {
        _middleCurrentIndex1++;
      } else {
        _middleCurrentIndex1 = 0;
      }
      _middlePageController1.animateToPage(
        _middleCurrentIndex1,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  void _startMiddleAutoSlide2() {
    _middleTimer2 = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_middleCurrentIndex2 < _middleBanners2.length - 1) {
        _middleCurrentIndex2++;
      } else {
        _middleCurrentIndex2 = 0;
      }
      _middlePageController2.animateToPage(
        _middleCurrentIndex2,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(onTap:(){
          Navigator.pop(context);

        }, child: Icon(Icons.arrow_back_ios, color: Colors.white)),
       backgroundColor: Theme.of(context).primaryColor,
        title: Text('Special Offers', style: TextStyle(color:Colors.white,fontFamily: 'Nunito')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _buildBannerPageView(_topBanners, _topPageController, _topCurrentIndex),
              SizedBox(height: 20),
              _buildBannerPageView(_middleBanners1, _middlePageController1, _middleCurrentIndex1),
              SizedBox(height: 20),
              _buildBannerPageView(_middleBanners2, _middlePageController2, _middleCurrentIndex2),
              SizedBox(height: 20),
              _buildBannerPageView(_bottomBanners, _bottomPageController, _bottomCurrentIndex),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBannerPageView(List<String> banners, PageController controller, int currentIndex) {
    return Container(
      height: 200,
      child: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: banners.length,
            itemBuilder: (context, index) {
              return FadeTransition(
                opacity: AlwaysStoppedAnimation(1.0),  // Or use other animations
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    banners[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                banners.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index
                        ? Colors.white
                        : Theme.of(context).primaryColor,
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
