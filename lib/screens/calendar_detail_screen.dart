import 'package:flutter/material.dart';
import 'package:supplement_app/config/theme.dart';
import 'package:intl/intl.dart';

class CalendarDetailScreen extends StatelessWidget {
  final String date;

  const CalendarDetailScreen({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime selectedDate = DateTime.parse(date);
    final String formattedDate = DateFormat.yMMMMd().format(selectedDate);

    // Dummy data for demonstration
    final supplements = [
      {
        'name': 'Vitamin D',
        'status': 'complete',
        'dosage': '2000 IU',
        'time': '8:00 AM',
        'taken_at': '8:05 AM',
        'notes': 'Taken with breakfast',
      },
      {
        'name': 'Omega-3',
        'status': 'partial',
        'dosage': '1000 mg',
        'time': '1:00 PM',
        'taken_at': '2:30 PM',
        'notes': 'Took only half dose',
        'recommendation': 'Take remaining 500mg with dinner',
      },
      {
        'name': 'Magnesium',
        'status': 'missed',
        'dosage': '400 mg',
        'time': '9:00 PM',
        'taken_at': null,
        'notes': 'Missed dose',
        'recommendation': 'Take 600mg tomorrow to compensate',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(formattedDate),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: supplements.length,
        itemBuilder: (context, index) {
          final supplement = supplements[index];
          return Card(
            child: ExpansionTile(
              leading: _getStatusIcon(supplement['status']!),
              title: Text(supplement['name']!),
              subtitle: Text('${supplement['dosage']} at ${supplement['time']}'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (supplement['taken_at'] != null) ...[
                        Text('Taken at: ${supplement['taken_at']}'),
                        const SizedBox(height: 8),
                      ],
                      Text('Notes: ${supplement['notes']}'),
                      if (supplement['recommendation'] != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Recommendation: ${supplement['recommendation']}',
                          style: TextStyle(
                            color: _getStatusColor(supplement['status']!),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
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
} 