import 'package:flutter/material.dart';
import 'package:moodmate/mood.dart';
import 'package:shared_preferences/shared_preferences.dart';

class onboarding extends StatefulWidget {
  @override
  _onboardingState createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  final controller = PageController();
  final TextEditingController nicknameController = TextEditingController(); // ✅

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

    // Optional: generate pages dynamically
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
    nicknameController.dispose(); // ✅ Clean up
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          onPageChanged: (index) {
            setState(() => islastpage = index == titles.length - 1);
          },
          controller: controller,
          children: [
            // Page 1
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/hi.png',
                    height: 300,
                    width: 300,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Hi There!",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            // Page 2 - Nickname input
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Who Are You?",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3.5,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Tell me your sweetest \nnickname!",
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 130, 30, 30),
                  child: TextField(
                    controller: nicknameController, // ✅
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: 'Your name',
                      contentPadding: const EdgeInsets.all(20),
                    ),
                  ),
                ),
              ],
            ),

            // Page 3 - Done
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/set.png',
                  height: 300,
                  width: 300,
                ),
                Text(
                  'We\'re all set!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: islastpage
          ? Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();

                    await prefs.setBool('onboardingDone', true); // ✅
                    String nickname = nicknameController.text.trim();
                    if (nickname.isNotEmpty) {
                      await prefs.setString('nickname', nickname); // ✅
                    }

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => corousal()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Get Started',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          : Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  titles.length,
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
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
