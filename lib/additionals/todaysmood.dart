


import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';



  // Color MoodColor = getMoodColor(todayMood);
   
   
      Color MoodColor = const Color(0xFF9BB068)
;


final moodBox = Hive.box('moods');
String? todayMood = moodBox.get(DateFormat('yyyy-MM-dd').format(DateTime.now()));
Color getMoodColor(String? mood) {
    switch (mood) {
      case 'awful':
        return Colors.red[300]!;
      case 'bad':
        return Colors.orange[300]!;
      case 'Meh':
        return Colors.grey[400]!;
      case 'good':
        return Colors.lightGreen[300]!;
      case 'rad':
        return Colors.green[500]!;
      default:
        return Colors.white;
    }
  }
 String todayMoodEmoji = getMoodpic(todayMood);
String getMoodpic(String? mood) {
    switch (mood) {
      case 'awful':
        return   "crying";
      case 'bad':
        return  "slightly_sad";
      case 'Meh':
        return "neutral";
      case 'good':
        return "slightly_smile";
      case 'rad':
        return  "big_smile";
      default:
        return "neutral";
    }
  }


final List<String> allChallengesPool = [
  'Take a 10-minute walk',
  'Compliment yourself in the mirror',
  'Write down 3 things you’re grateful for',
  'Text or talk to a friend',
  'Stretch for 5 minutes',
  'Drink a glass of water',
  'Organize one small area around you',
  'Smile at a stranger or yourself',
  'Take 3 deep breaths slowly',
  'Write a short journal entry',
  'Sit silently for 2 minutes',
  'Try a power pose for confidence',
  'Send a kind message to someone',
  'Give a hug (or virtual one)',
  'Watch a funny video',
  'Draw something quickly',
  'Plan something fun this week',
  'Say no to a distraction for 30 min',
  'Say a positive affirmation aloud',
  'Look out a window for 2 minutes',
  'Clean your phone screen',
  'Walk barefoot for a moment',
  'Tidy your room desk',
  'Smile and hold it for 10 seconds',
  'Think of a happy memory'
];


 final List<String> quotes = [
    "Be yourself; everyone else is already taken.",
    "You only live once, but if you do it right, once is enough.",
    "In the middle of difficulty lies opportunity.",
    "The best way to predict the future is to invent it.",
    "Believe you can and you're halfway there.",
    "Happiness is not something ready-made. It comes from your own actions."
  ];

  class QuoteSource {
  static List<Map<String, String>> quotes = [
    {
      'quote': "Whoever tries to pull you down is already below you.",
      'author': "Alexander"
    },
    {
      'quote': "Be yourself; everyone else is already taken.",
      'author': "Oscar Wilde"
    },
    {
      'quote': "Happiness is not ready-made. It comes from your actions.",
      'author': "Dalai Lama"
    },
    {
      'quote': "In the middle of difficulty lies opportunity.",
      'author': "Einstein"
    },
    {
      'quote': "Act as if what you do makes a difference. It does.",
      'author': "William James"
    },
  ];
}
