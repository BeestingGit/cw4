import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: PlanManagerScreen());
  }
}

class Plan {
  String name;
  String description;
  DateTime date;
  bool isCompleted;
  Plan({
    required this.name,
    required this.description,
    required this.date,
    this.isCompleted = false,
  });
}

class PlanManagerScreen extends StatefulWidget {
  @override
  _PlanManagerScreenState createState() => _PlanManagerScreenState();
}

class _PlanManagerScreenState extends State<PlanManagerScreen> {
  List<Plan> plans = []; // List to store plans

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Plan Manager")),
      body: Column(
        children: [
          Expanded(
            child: ListView(), // Placeholder for the plan list
          ),
          ElevatedButton(
            onPressed: () {}, // Placeholder for "Create Plan" button
            child: Text("Create Plan"),
          ),
        ],
      ),
    );
  }
}
