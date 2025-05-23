import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moodmate/additionals/todaysmood.dart'; // For getMoodpic()

class WeeklyMoodBar extends StatelessWidget {
  final Box moodBox = Hive.box('moods');

  WeeklyMoodBar({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final todayWeekday = now.weekday;
    final monday = now.subtract(Duration(days: todayWeekday - 1));

    List<DateTime> weekDates = List.generate(7, (index) => monday.add(Duration(days: index)));
    List<String> dayLabels = ['Mn', 'Tu', 'Wd', 'Th', 'Fr', 'Sa', 'Su'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Dynamically scale text and emoji size
          double emojiSize = constraints.maxWidth / 10;
          double textSize = constraints.maxWidth / 30;

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (index) {
                final date = weekDates[index];
                final formatted = DateFormat('yyyy-MM-dd').format(date);
                final mood = moodBox.get(formatted);
                final emojiAsset = mood != null ? 'assets/${getMoodpic(mood)}.svg' : null;

                return Column(
                  children: [
                    Text(
                      dayLabels[index],
                      style: TextStyle(
                        fontSize: textSize,
                        color: MoodColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    emojiAsset != null
                        ? SvgPicture.asset(
                            emojiAsset,
                            width: emojiSize,
                            height: emojiSize,
                          )
                        : Container(
                            width: emojiSize,
                            height: emojiSize,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                          ),
                  ],
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
