import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:supplement_app/config/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplement Tracker'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              context.go('/home/day/${DateFormat('yyyy-MM-dd').format(selectedDay)}');
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
          ),
          const Divider(),
          Expanded(
            child: _buildDailyOverview(),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyOverview() {
    // Dummy data for demonstration
    final supplements = [
      {'name': 'Vitamin D', 'status': 'complete', 'dosage': '2000 IU', 'time': '8:00 AM'},
      {'name': 'Omega-3', 'status': 'partial', 'dosage': '1000 mg', 'time': '1:00 PM'},
      {'name': 'Magnesium', 'status': 'missed', 'dosage': '400 mg', 'time': '9:00 PM'},
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daily Overview',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: supplements.length,
              itemBuilder: (context, index) {
                final supplement = supplements[index];
                return Card(
                  child: ListTile(
                    leading: _getStatusIcon(supplement['status']!),
                    title: Text(supplement['name']!),
                    subtitle: Text('${supplement['dosage']} at ${supplement['time']}'),
                    trailing: _getStatusMessage(supplement['status']!),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getStatusIcon(String status) {
    final color = _getStatusColor(status);
    IconData icon;
    switch (status) {
      case 'complete':
        icon = Icons.check_circle;
        break;
      case 'partial':
        icon = Icons.warning;
        break;
      case 'missed':
        icon = Icons.cancel;
        break;
      default:
        icon = Icons.help;
    }
    return Icon(icon, color: color);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'complete':
        return AppTheme.successGreen;
      case 'partial':
        return AppTheme.warningYellow;
      case 'missed':
        return AppTheme.errorRed;
      default:
        return Colors.grey;
    }
  }

  Widget _getStatusMessage(String status) {
    String message = '';
    switch (status) {
      case 'partial':
        message = 'Take remaining dose';
        break;
      case 'missed':
        message = 'Adjust tomorrow\'s dose';
        break;
      default:
        return const SizedBox.shrink();
    }
    return Text(
      message,
      style: TextStyle(
        color: _getStatusColor(status),
        fontSize: 12,
      ),
    );
  }
} 