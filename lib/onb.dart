import 'package:flutter/material.dart';

class onboarding extends StatefulWidget {
  @override
  _onboardingState createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  final controller = PageController();
  int activePage = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        activePage = controller.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          children: [
            Container(
              color: Colors.blue,
              child: Center(child: Text('Page1')),
            ),
            Container(
              color: Colors.red,
              child: Center(child: Text('Page2')),
            ),
            Container(
              color: Colors.amber,
              child: Center(child: Text('Page3')),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => controller.jumpToPage(2),
              child: Text('Skip'),
            ),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                      3,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: InkWell(
                              onTap: () {
                                controller.animateToPage(index,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: activePage == index
                                      ? Colors.yellow
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ))),
            ),
            TextButton(
              onPressed: () => controller.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut),
              child: Text('Next'),
            )
          ],
        ),
      ),
    );
  }
}
