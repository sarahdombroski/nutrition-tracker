import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);
  
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Screen'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2020),
            lastDay: DateTime(2100),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },

            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });

              // LOAD DATA!!!
              print("Selected: $selectedDay");
            },

            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,

            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),

          const SizedBox(height: 16),

          // 👇 Display daily data here
          Expanded(
            child: Center(
              child: Text(
                _selectedDay == null
                    ? "Select a day"
                    : "Showing logs for: ${_selectedDay!.toLocal().toString().split(' ')[0]}",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}