import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoodChallengeLogic extends ChangeNotifier {
  final List<String> allChallenges = [
    'Smile to 3 people you see',
    'Say something kind to a friend',
    'Take 10 deep breaths',
    'Drink a full glass of water',
    'Write one thing you’re grateful for',
    'Compliment someone sincerely',
    'Stretch for 2 minutes',
    'Spend 5 minutes in silence',
    'Avoid social media for 1 hour',
    'Sit in sunlight for 5 minutes',
    'Look out the window and observe',
    'Draw something random',
    'Talk to someone you’ve ignored',
    'Do 5 squats right now',
    'Organize one drawer or shelf',
    'Smile at yourself in the mirror',
    'Give someone a genuine thank you',
  ];

  List<String> _todayChallenges = [];
  int _currentIndex = 0;
  Set<int> _completedIndexes = {};

  MoodChallengeLogic() {
    _generateChallenges();
  }
  
  void _generateChallenges() {
    allChallenges.shuffle();
    _todayChallenges = allChallenges.take(3).toList();
    _currentIndex = 0;
    _completedIndexes.clear();
    notifyListeners();
  }

  String get currentChallenge =>
      _todayChallenges.isNotEmpty ? _todayChallenges[_currentIndex] : '';

String get progressText {
  if (_completedIndexes.length <3) {
    return '${_completedIndexes.length + 1} of ${_todayChallenges.length}';
  } else {
    return 'completed';
  }
}
  void swapChallenge() {
    _currentIndex = (_currentIndex + 1) % _todayChallenges.length;
    notifyListeners();
  }

  void markCurrentAsCompleted() {
    _completedIndexes.add(_currentIndex);
    int next = _todayChallenges.indexWhere(
      (element) =>
          !_completedIndexes.contains(_todayChallenges.indexOf(element)),
      _currentIndex + 1,
    );
    if (next == -1) {
      next = _todayChallenges.indexWhere(
        (element) =>
            !_completedIndexes.contains(_todayChallenges.indexOf(element)),
      );
    }
    if (next != -1) {
      _currentIndex = next;
    }
    notifyListeners();
  }
}

class MoodChallengeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodChallengeLogic>(
      builder: (context, logic, _) => Container(
        
        width: MediaQuery.of(context).size.width,
        height: 170,
        decoration: BoxDecoration(boxShadow:[
           BoxShadow(
         color: Colors.black.withOpacity(0.07),
      offset: Offset(0, 6), // No X shift, only down
      blurRadius: 12,       // Softness
      spreadRadius: 0,      // No spread
                                  )
                                  ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: Text(
                    logic.progressText,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9BB068),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              logic.currentChallenge,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF9BB068),
              ),
            ),
            Spacer(),
            Divider(
              indent: 5,
              endIndent: 5,
              thickness: 2,
              height: 1,
              color: Color.fromARGB(255, 230, 235, 218),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => logic.swapChallenge(),
                      child: Text(
                        "Swap",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF9BB068),
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    endIndent: 3,
                    thickness: 2,
                    width: 1,
                    color: Color.fromARGB(255, 230, 235, 218),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => logic.markCurrentAsCompleted(),
                      child: Text(
                        "Accept",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF9BB068),
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
