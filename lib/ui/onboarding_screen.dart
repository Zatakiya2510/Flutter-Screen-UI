import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plant_test_ui/constants.dart';
import 'package:plant_test_ui/ui/root_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();




















    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      _scrollToNextPage();
    });
  }

  void _scrollToNextPage() {
    setState(() {
      if (currentIndex < 2) {
        currentIndex++;
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        _navigateToRootPage();
      }
    });
  }

  void _navigateToRootPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const RootPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: InkWell(
              onTap: _navigateToRootPage,
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView(
                  onPageChanged: (int page) {
                    setState(() {
                      currentIndex = page;
                    });
                  },
                  controller: _pageController,
                  children: [
                    OnboardingPage(
                      image: 'assets/images/plant-one.png',
                      title: Constants.titleOne,
                      description: Constants.descriptionOne,
                      constraints: constraints,
                    ),
                    OnboardingPage(
                      image: 'assets/images/plant-two.png',
                      title: Constants.titleTwo,
                      description: Constants.descriptionTwo,
                      constraints: constraints,
                    ),
                    OnboardingPage(
                      image: 'assets/images/plant-three.png',
                      title: Constants.titleThree,
                      description: Constants.descriptionThree,
                      constraints: constraints,
                    ),
                  ],
                ),
                Positioned(
                  bottom: constraints.maxHeight * 0.1,
                  left: constraints.maxWidth * 0.05,
                  child: Row(
                    children: _buildIndicator(),
                  ),
                ),
                Positioned(
                  bottom: constraints.maxHeight * 0.08,
                  right: constraints.maxWidth * 0.05,
                  child: Container(
                    child: IconButton(
                      onPressed: _scrollToNextPage,
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Constants.primaryColor,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 3; i++) {
      indicators.add(_indicator(i == currentIndex));
    }

    return indicators;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10.0,
      width: isActive ? 20 : 8,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: Constants.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final BoxConstraints constraints;

  const OnboardingPage({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: constraints.maxWidth * 0.1,
        vertical: constraints.maxHeight * 0.05, // Adjusted vertical padding
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.5,
            child: Image.asset(image),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Constants.primaryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
