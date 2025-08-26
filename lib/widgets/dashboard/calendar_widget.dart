import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../constants/app_colors.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'January 2024',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.chevron_left, color: Colors.grey[600]),
                    const SizedBox(width: 12),
                    Icon(Icons.chevron_right, color: Colors.grey[600]),
                  ],
                ),
              ],
            ),
          ),
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: DateTime.utc(2024, 1, 19),
            headerVisible: false,
            daysOfWeekHeight: 24,
            rowHeight: 36,
            calendarFormat: CalendarFormat.month,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              todayDecoration: const BoxDecoration(
                color: AppColors.todayHighlight,
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: AppColors.todayHighlight,
                shape: BoxShape.circle,
              ),
              defaultTextStyle: const TextStyle(fontSize: 12),
              weekendTextStyle: const TextStyle(fontSize: 12),
              todayTextStyle: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
              selectedTextStyle: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(fontSize: 12),
              weekendStyle: TextStyle(fontSize: 12),
            ),
            selectedDayPredicate: (day) {
              return isSameDay(day, DateTime.utc(2024, 1, 19));
            },
          ),
        ],
      ),
    );
  }
}
