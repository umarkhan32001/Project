import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pakistan Provinces',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedCount = 0;

  void _updateProgress(bool isSelected) {
    setState(() {
      _selectedCount += isSelected ? 1 : -1;
    });
  }

  void _showMessage(BuildContext context, String province) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('So! You are from $province!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pakistan Provinces'),
      ),
      body: Column(
        children: [
          Progress(progress: _selectedCount / 5),
          TaskList(updateProgress: _updateProgress, showMessage: _showMessage),
        ],
      ),
    );
  }
}

class Progress extends StatelessWidget {
  final double progress;

  const Progress({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Which province are you from?'),
        LinearProgressIndicator(value: progress),
      ],
    );
  }
}

class TaskList extends StatelessWidget {
  final Function(bool) updateProgress;
  final Function(BuildContext, String) showMessage;

  const TaskList({super.key, required this.updateProgress, required this.showMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TaskItem(label: 'Balochistan', updateProgress: updateProgress, showMessage: showMessage),
        TaskItem(label: 'Khyber Pakhtunkhwa', updateProgress: updateProgress, showMessage: showMessage),
        TaskItem(label: 'Sindh', updateProgress: updateProgress, showMessage: showMessage),
        TaskItem(label: 'Punjab', updateProgress: updateProgress, showMessage: showMessage),
        TaskItem(label: 'Gilgit-Baltistan', updateProgress: updateProgress, showMessage: showMessage),
      ],
    );
  }
}

class TaskItem extends StatefulWidget {
  final String label;
  final Function(bool) updateProgress;
  final Function(BuildContext, String) showMessage;

  const TaskItem({super.key, required this.label, required this.updateProgress, required this.showMessage});

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _isSelected,
          onChanged: (bool? newValue) {
            setState(() {
              _isSelected = newValue!;
              widget.updateProgress(_isSelected);
              if (_isSelected) {
                widget.showMessage(context, widget.label);
              }
            });
          },
        ),
        Text(widget.label),
      ],
    );
  }
}
