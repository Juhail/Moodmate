import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moodmate/mood.dart';
import 'package:shared_preferences/shared_preferences.dart';

class onboarding extends StatefulWidget {
  @override
  _onboardingState createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  final controller = PageController();
  int activePage = 0;
  bool islastpage = false;
  List<String> titles = ["Hi There!", "Page2", "Page3"];
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        activePage = controller.page?.round() ?? 0;
      });
    });

    // Initialize the pages list
    pages = List.generate(
      titles.length,
      (index) => Column(
        children: [
          Center(
            child: Text(
              titles[index],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
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
          onPageChanged: (index) {
            setState(() => islastpage = index == titles.length - 1);
          },
          controller: controller,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hi There!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: SvgPicture.asset(
                    'asset/hi.svg',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  "Who AreYou ?",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                  ),
                ),
              ],
            ),
            Column(children: [
              Text(
                'We\'re all set!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SvgPicture.asset(
                'asset/set.svg',
                height: 300,
                width: 300,
                fit: BoxFit.cover,
              )
            ])
          ],
        ),
      ),
      bottomSheet: islastpage
          ? TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => corousal()));
              },
              child: Text('Get Started'))
          : Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(
                          titles.length,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ))),
                ],
              ),
            ),
    );
  }
}
