import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'data.dart' as globals;

// helper function to format the display
String formatKey(String key) {
  return key
      .replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m.group(0)}')
      .trim()
      .split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});
  
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<String, dynamic>? _dailyData;
  
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
              final timestamp = selectedDay.toIso8601String().split('T')[0];
              globals.getDataFromDate(timestamp).then((data) {
                setState(() {
                  _dailyData = data;
                });
              });
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
            child: _selectedDay == null
              ? const Center(
                  child: Text(
                    "Select a day",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : _dailyData == null || _dailyData!.isEmpty
                ? const Center(child: Text("Select a day"))
                : _dailyData!.isEmpty
                  ? Center(child: Text("No data for selected day"))
                  : ListView(
                    padding: const EdgeInsets.all(16),
                    children: _dailyData!.entries.map((entry) {
                      final title = entry.key;
                      final details = entry.value;

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formatKey(title),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              
                              // Display details
                              ...details.entries.map((detail) {
                                return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: 
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                          formatKey(detail.key),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                    Text(
                                      detail.value.toString(),
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              );})
                            ],
                          ),
                        )
                      );
                    }).toList(),
                  )
          ),
        ],
      ),
    );
  }
}