import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/colors/app_colors.dart';
import 'package:flutter_golang_yt/screens/all_task.dart';
import 'package:flutter_golang_yt/screens/home_screen.dart';
import 'package:flutter_golang_yt/widgets/button_widget.dart';
import 'package:flutter_golang_yt/widgets/textfield_widget.dart';

class UpdateTask extends StatefulWidget {
  final String taskId;
  UpdateTask({Key? key, required this.taskId}) : super(key: key);
  @override
  _UpdateTaskState createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  late TextEditingController nameController;
  late TextEditingController detailController;
  String taskTitle = '';
  String taskDetail = '';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    detailController = TextEditingController();

    getTaskDetail();
  }

  // Fetch the task details from Firebase based on the taskId passed from the AllTasks page
  Future<void> getTaskDetail() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('task')
        .where('TitleTask', isEqualTo: widget.taskId)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs[0].data();
      setState(() {
        taskTitle = data['TitleTask'];
        taskDetail = data['DetailTask'];
        nameController.text = taskTitle;
        detailController.text = taskDetail;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding: const EdgeInsets.only(left: 20, right: 20),
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/addtask1.jpg")),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Column(
          children: [
          const SizedBox(
          height: 40,
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.secondaryColor,
              ))
          ],
        ), //column for the page header section
        Column(
          children: [
          TextFieldWidget(
          textController: nameController,
          labelText: 'Title Task',
          hintText: 'Title Task',
        ),
        const SizedBox(
          height: 20,
        ),
        TextFieldWidget(
          textController: detailController,
          labelText: 'Detail Task',
          hintText: "Details of Task",
          borderRadius: 15,
          maxLines: 3,
        ),
        const SizedBox(
          height: 20,
        ),
            GestureDetector(
              onTap: () async {
                final doc = await FirebaseFirestore.instance
                    .collection("task")
                    .where('TitleTask', isEqualTo: nameController.text)
                    .get()
                    .then((querySnapshot) => querySnapshot.docs.first);
                doc.reference.update({
                  "TitleTask": nameController.text,
                  "DetailTask": detailController.text,
                }).then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AllTasks()),
                  );
                }) ;
              },
              child: ButtonWidget(
                  backgroundcolor: AppColors.mainColor,
                  text: "Edit",
                  textColor: Colors.white),
            )

          ],
        ),
              SizedBox(
                  height: MediaQuery.of(context).size.height/20
              )],
          ),
        ),
    );
  }
}