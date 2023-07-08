import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../auth/register.dart';
import '../constants/constants.dart';

class PageViewpage extends StatefulWidget {
  const PageViewpage({super.key});

  @override
  State<PageViewpage> createState() => _PageViewpageState();
}

class _PageViewpageState extends State<PageViewpage> {
  PageController pageController = PageController(initialPage: 0);
  int pageIndex = 0;
  int _currentPage = 0;
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              pageIndex = index;
              _currentPage = index;
            });
          },
          itemCount: introList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 55,
                  ),
                  //image
                  Image.asset(
                    '${introList[index]['image']}',
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(
                    height: 45,
                  ),

                  //title
                  Text(
                    '${introList[index]['title']}',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  //des
                  Text(
                    '${introList[index]['des']}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 29, 29, 29)),
                  ),
                  Spacer(),

                  //indicator
                  Center(
                    child: SmoothPageIndicator(
                        controller: pageController, // PageController
                        count: introList.length,
                        effect: WormEffect(), // your preferred effect
                        onDotClicked: (index) {}),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  //button
                  _currentPage + 1 == introList.length
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: _currentPage + 1 == introList.length
                                  ? () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterPage()));
                                    }
                                  : () {
                                      pageController.animateToPage(index,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeIn);
                                    },
                              child: Container(
                                height: 55,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                      _currentPage + 1 == introList.length
                                          ? 'Register'
                                          : 'Next Slide',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  Spacer(),
                ],
              ),
            );
          }),
    );
  }
}
