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

  void addPlan(String name, String description, DateTime date) {
    setState(() {
      plans.add(Plan(name: name, description: description, date: date));
    });
  }

  void markAsCompleted(int index) {
    setState(() {
      plans[index].isCompleted = true;
    });
  }

  void openEditPlanModal(int index) {
    String updatedName = plans[index].name;
    String updatedDescription = plans[index].description;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Plan"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Plan Name"),
                controller: TextEditingController(text: updatedName),
                onChanged: (value) => updatedName = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Description"),
                controller: TextEditingController(text: updatedDescription),
                onChanged: (value) => updatedDescription = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                updatePlan(index, updatedName, updatedDescription);
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void updatePlan(int index, String name, String description) {
    setState(() {
      plans[index].name = name;
      plans[index].description = description;
    });
  }

  void removePlan(int index) {
    setState(() {
      plans.removeAt(index);
    });
  }

  void openCreatePlanModal() {
    showDialog(
      context: context,
      builder: (context) {
        String name = "";
        String description = "";
        DateTime selectedDate = DateTime.now();

        return AlertDialog(
          title: Text("Create Plan"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Plan Name"),
                onChanged: (value) => name = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Description"),
                onChanged: (value) => description = value,
              ),
              TextButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) selectedDate = pickedDate;
                },
                child: Text("Pick Date"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                addPlan(name, description, selectedDate);
                Navigator.of(context).pop();
              },
              child: Text("Create"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Plan Manager")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: plans.length,
              itemBuilder: (context, index) {
                final plan = plans[index];
                return GestureDetector(
                  onLongPress: () => openEditPlanModal(index),
                  onDoubleTap: () => removePlan(index),
                  child: Dismissible(
                    key: UniqueKey(),
                    onDismissed: (_) => markAsCompleted(index),
                    child: ListTile(
                      title: Text(
                        plan.name,
                        style: TextStyle(
                          color: plan.isCompleted ? Colors.green : Colors.black,
                        ),
                      ),
                      subtitle: Text(plan.description),
                      trailing: Text(
                        "${plan.date.month}/${plan.date.day}/${plan.date.year}",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: openCreatePlanModal,
            child: Text("Create Plan"),
          ),
        ],
      ),
    );
  }
}
