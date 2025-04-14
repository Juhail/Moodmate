

import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';


final moodBox = Hive.box('moods');
String? todayMood = moodBox.get(DateFormat('yyyy-MM-dd').format(DateTime.now()));
