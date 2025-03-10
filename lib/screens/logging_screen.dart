import 'package:flutter/material.dart';
import 'package:supplement_app/config/theme.dart';

class LoggingScreen extends StatefulWidget {
  const LoggingScreen({super.key});

  @override
  State<LoggingScreen> createState() => _LoggingScreenState();
}

class _LoggingScreenState extends State<LoggingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  TimeOfDay _selectedNotificationTime = TimeOfDay.now();
  Duration _notificationInterval = const Duration(minutes: 30);
  String _missedDosageAction = '';

  // Predefined supplements for quick selection
  final List<Map<String, String>> _commonSupplements = [
    {
      'name': 'Vitamin D3',
      'dosage': '2000-4000 IU daily',
      'timing': 'Morning with food',
    },
    {
      'name': 'Vitamin B12',
      'dosage': '2.4 mcg daily',
      'timing': 'Morning',
    },
    {
      'name': 'Omega-3',
      'dosage': '1000-2000 mg daily',
      'timing': 'With meals',
    },
    {
      'name': 'Magnesium',
      'dosage': '310-420 mg daily',
      'timing': 'Evening',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Supplements'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCommonSupplementsSection(),
            const Divider(height: 32),
            _buildCustomSupplementForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildCommonSupplementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Common Supplements',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _commonSupplements.length,
          itemBuilder: (context, index) {
            final supplement = _commonSupplements[index];
            return Card(
              child: ListTile(
                title: Text(supplement['name']!),
                subtitle: Text('${supplement['dosage']}\n${supplement['timing']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.add_circle),
                  color: AppTheme.primaryYellow,
                  onPressed: () {
                    _nameController.text = supplement['name']!;
                    _dosageController.text = supplement['dosage']!;
                  },
                ),
                isThreeLine: true,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCustomSupplementForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Custom Supplement',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Supplement Name',
              prefixIcon: Icon(Icons.medication),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _dosageController,
            decoration: const InputDecoration(
              labelText: 'Dosage',
              prefixIcon: Icon(Icons.scale),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter dosage';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: const Text('Time to Take'),
            subtitle: Text(_selectedTime.format(context)),
            onTap: () async {
              final TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: _selectedTime,
              );
              if (time != null) {
                setState(() => _selectedTime = time);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification Time'),
            subtitle: Text(_selectedNotificationTime.format(context)),
            onTap: () async {
              final TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: _selectedNotificationTime,
              );
              if (time != null) {
                setState(() => _selectedNotificationTime = time);
              }
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<Duration>(
            decoration: const InputDecoration(
              labelText: 'Reminder Interval',
              prefixIcon: Icon(Icons.timer),
            ),
            value: _notificationInterval,
            items: [
              DropdownMenuItem(
                value: const Duration(minutes: 30),
                child: const Text('30 minutes'),
              ),
              DropdownMenuItem(
                value: const Duration(hours: 1),
                child: const Text('1 hour'),
              ),
              DropdownMenuItem(
                value: const Duration(hours: 2),
                child: const Text('2 hours'),
              ),
            ],
            onChanged: (value) {
              setState(() => _notificationInterval = value!);
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Missed Dose Action',
              prefixIcon: Icon(Icons.warning),
            ),
            maxLines: 3,
            onChanged: (value) => _missedDosageAction = value,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Add Supplement'),
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement saving to Firebase
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Supplement added successfully')),
      );
      _formKey.currentState!.reset();
      _nameController.clear();
      _dosageController.clear();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    super.dispose();
  }
} 