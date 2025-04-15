import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

class MoodCalendar extends StatefulWidget {
  @override
  _MoodCalendarState createState() => _MoodCalendarState();
}

class _MoodCalendarState extends State<MoodCalendar> {
  DateTime _focusedDate = DateTime.now();
  DateTime? _selectedDate;
  late Box moodBox;

  @override
  void initState() {
    super.initState();
    moodBox = Hive.box('moods'); // Make sure it's opened before calling this screen
  }

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

  @override
  Widget build(BuildContext context) {
    final currentMonth = DateFormat.yMMMM().format(_focusedDate);
    final daysInMonth = DateUtils.getDaysInMonth(_focusedDate.year, _focusedDate.month);
    final firstDayOfMonth = DateTime(_focusedDate.year, _focusedDate.month, 1);
    final startWeekday = firstDayOfMonth.weekday % 7;

    final totalCells = startWeekday + daysInMonth;

    final dayTiles = List.generate(totalCells, (index) {
      if (index < startWeekday) return Container(); // Empty start

      final day = index - startWeekday + 1;
      final thisDate = DateTime(_focusedDate.year, _focusedDate.month, day);
      final formattedDate = DateFormat('yyyy-MM-dd').format(thisDate);
      final savedMood = moodBox.get(formattedDate); // 'awful', 'bad', etc

      final isToday = DateTime.now().day == day &&
          DateTime.now().month == _focusedDate.month &&
          DateTime.now().year == _focusedDate.year;

      final isSelected = _selectedDate != null &&
          _selectedDate!.day == day &&
          _selectedDate!.month == _focusedDate.month &&
          _selectedDate!.year == _focusedDate.year;

      final moodColor = getMoodColor(savedMood);

      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedDate = thisDate;
          });
        },
        child: Container(
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: savedMood != null
                ? moodColor
                : (isToday ? Colors.green[100] : Colors.white),
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              '$day',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.black : Colors.grey[800],
              ),
            ),
          ),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(title: Text('Mood Calendar')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month - 1);
                    });
                  },
                ),
                Text(
                  currentMonth,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + 1);
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ["S", "M", "T", "W", "T", "F", "S"]
                    .map((e) => Expanded(
                          child: Center(
                            child: Text(
                              e,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: dayTiles,
            ),
            SizedBox(height: 20),

            if (_selectedDate != null)
              Column(
                children: [
                  Text(
                    'Mood for ${DateFormat.yMMMd().format(_selectedDate!)}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    moodBox.get(DateFormat('yyyy-MM-dd').format(_selectedDate!)) ?? "No mood saved",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
