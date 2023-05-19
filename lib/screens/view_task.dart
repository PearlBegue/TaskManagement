import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../colors/app_colors.dart';
import 'home_screen.dart';

class ViewTask extends StatefulWidget {
  final String taskTitle;

  ViewTask({required this.taskTitle});

  @override
  _ViewTaskState createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  String taskDetail = '';

  @override
  void initState() {
    super.initState();
    getTaskDetail();
  }

  Future<void> getTaskDetail() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('task')
        .where('TitleTask', isEqualTo: widget.taskTitle)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final task = snapshot.docs.first;
      setState(() {
        taskDetail = task.get('DetailTask');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Column(
        children: [
        Container(
          padding: const EdgeInsets.only(left: 20, top: 60),
            alignment: Alignment.topLeft,

            width: double.maxFinite,
            height: MediaQuery.of(context).size.height/3.2,
            decoration: const BoxDecoration(
            image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
                    "assets/header1.jpg"
            )
            )
            ),
            ),
// section header of the page
              Flexible(
                  child: Scaffold(
                  appBar: AppBar(
                      title: Text(widget.taskTitle),
                      ),
                    body: Center(
                      child: Text(taskDetail.isEmpty ? 'Loading...' : taskDetail, style: TextStyle(fontSize: 22.0),),
                    ),

                    )
          )

          ])
        );
      }}