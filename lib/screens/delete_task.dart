import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_golang_yt/screens/all_task.dart';
import '../colors/app_colors.dart';
import '../widgets/button_widget.dart';

class DeleteTaskPage extends StatefulWidget {
  final String taskID;

  DeleteTaskPage({required this.taskID});

  @override
  _DeleteTaskPageState createState() => _DeleteTaskPageState();
}

class _DeleteTaskPageState extends State<DeleteTaskPage> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Task'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Are you sure you want to delete this task?",
                style: TextStyle(fontSize: 18.0,),
              ),
              SizedBox(height: 10.0),
              Text(
                "Title: ${widget.taskID}",
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              _isDeleting
                  ? CircularProgressIndicator()
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          _isDeleting = true;
                        });
                        await deleteTask(widget.taskID);
                        setState(() {
                          _isDeleting = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AllTasks()),
                        );
                      },
                      child: ButtonWidget(
                        backgroundcolor: Colors.red,
                        text: "Delete",
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AllTasks()),
                        );
                      },
                      child: ButtonWidget(
                        backgroundcolor: AppColors.mainColor,
                        text: "Cancel",
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteTask(String taskID) async {
    // Query Firebase to find task by title
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('task')
        .where('TitleTask', isEqualTo: taskID)
        .get();

    // Delete task from Firebase and remove from list
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      await documentSnapshot.reference.delete();
    }
  }
}
