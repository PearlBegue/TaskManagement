import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/screens/all_task.dart';
import 'package:flutter_golang_yt/screens/home_screen.dart';
import '../colors/app_colors.dart';
import '../widgets/button_widget.dart';
import '../widgets/textfield_widget.dart';



  class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);
  @override
  State<AddTask> createState() => _AddTaskState();
  }
  class _AddTaskState extends State<AddTask>{
  TextEditingController nameController = new TextEditingController();
  TextEditingController detailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(left: 20, right: 20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/addtask1.jpg"
            )
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
                children:[
                  const SizedBox(height: 40,),
                  IconButton(onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                      icon: Icon(Icons.arrow_back,
                        color: AppColors.secondaryColor,
                      ))
            ]), //column for the page header section
            Column(
              children: [
               TextFieldWidget(
                  textController: nameController,
                   labelText: 'Title Task',
                   hintText: 'Title Task',

                   ),
                const SizedBox(height: 20,),
                TextFieldWidget(
                    textController: detailController,
                    labelText:'Detail Task',
                    hintText: "Details of Task",
                    borderRadius: 15,
                maxLines: 3,),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Map<String,dynamic> tasks={
                      "TitleTask": nameController.text,
                      "DetailTask": detailController.text,
                    };
                    FirebaseFirestore.instance.collection("task").add(tasks);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AllTasks()),
                      );
                  },
                  child: ButtonWidget(
                      backgroundcolor: AppColors.mainColor,
                      text: "Add",
                      textColor: Colors.white),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/20,
            )
          ],
        ),
      ),
    );
  }
}
