import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TaskStatusChart extends StatefulWidget {
  @override
  _TaskStatusChartState createState() => _TaskStatusChartState();
}

class _TaskStatusChartState extends State<TaskStatusChart> {
  int _numTrue = 0;
  int _numFalse = 0;

  @override
  void initState() {
    super.initState();
    _getTaskData();
  }

  Future<void> _getTaskData() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('Tasks').get();
    int numTrue = 0;
    int numFalse = 0;
    querySnapshot.docs.forEach((doc) {
      bool? status = doc.data() != null &&
          (doc.data() as Map<String, dynamic>).containsKey('status')
          ? (doc.data() as Map<String, dynamic>)['status'] as bool?
          : null;

      if (status != null) {
        if (status) {
          numTrue++;
        } else {
          numFalse++;
        }
      }
    });
    setState(() {
      _numTrue = numTrue;
      _numFalse = numFalse;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<TaskStatus, String>> seriesList = [
      new charts.Series<TaskStatus, String>(
        id: 'TaskStatus',
        domainFn: (TaskStatus status, _) => status.status,
        measureFn: (TaskStatus status, _) => status.count,
        data: [
          new TaskStatus('Completed', _numTrue),
          new TaskStatus('Incompleted', _numFalse),
        ],
        colorFn: (TaskStatus status, _) =>
        status.status == 'Completed' ? charts.MaterialPalette.green.shadeDefault : charts.MaterialPalette.red.shadeDefault,
      ),
    ];

    return SafeArea(
      child: Container(
        /*color: Color.fromARGB(255, 235, 215, 164),*/

        padding: EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task Status Chart',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Completed: $_numTrue',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            Text(
              'Incompleted: $_numFalse',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            SizedBox(height: 16.0),
            Container(
              height: 600.0,
              child: charts.BarChart(
                seriesList,
                animate: true,
                barGroupingType: charts.BarGroupingType.grouped,
                vertical: true,
                barRendererDecorator: new charts.BarLabelDecorator<String>(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskStatus {
  final String status;
  final int count;

  TaskStatus(this.status, this.count);
}
