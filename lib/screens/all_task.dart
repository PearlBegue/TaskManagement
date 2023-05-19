import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/colors/app_colors.dart';
import 'package:flutter_golang_yt/screens/add_task.dart';
import 'package:flutter_golang_yt/screens/home_screen.dart';
import 'package:flutter_golang_yt/screens/update.dart';
import 'package:flutter_golang_yt/screens/view_task.dart';
import 'package:flutter_golang_yt/widgets/task_widget.dart';
import '../widgets/button_widget.dart';
import 'delete_task.dart';

class AllTasks extends StatefulWidget{
  @override
  State<AllTasks> createState() => _AllTaskState();
}
class _AllTaskState extends State<AllTasks> {
  List<String> _TitleTask=[]; // holds the fetched task titles
  @override
  void initState() {
    super.initState();
    _fetchTasks(); // fetch tasks when the widget is initialized
  }
  Future<void> _fetchTasks() async {
    final snapshot = await FirebaseFirestore.instance.collection('task').get();
    snapshot.docs.forEach((doc) {
      final titleTask = doc.get('TitleTask');
      setState(() {
        _TitleTask.add(titleTask);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_TitleTask == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final leftEditIcon = Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: const Color(0xFF2e3253).withOpacity(0.5),
      child: const Icon(
        Icons.edit,
        color: Colors.white,
      ), // Icon
      alignment: Alignment.centerLeft,
    ); // left side  of slide
    final rightDeleteIcon = Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.redAccent,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ), //Icon
      alignment: Alignment.centerRight,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, top: 60),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Icon(Icons.arrow_back, color: AppColors.secondaryColor),
              ),
              width: double.maxFinite,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 3.2,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          "assets/header1.jpg"
                      )
                  )
              ),
            ), //section header of the page
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      child: Icon(Icons.home, color: AppColors.secondaryColor,)
                  ),
                  SizedBox(width: 20,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddTask()));
                    }, // ontap gestureDetector
                    child: Container(
                      child: Icon(Icons.add, color: Colors.white, size: 20,),
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.5),
                          color: Colors.black
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Icon(Icons.file_copy_sharp, color: AppColors.secondaryColor,),
                  SizedBox(width: 20,),
                ], // children of row child
              ),
            ),
            Flexible(
                child: ListView.builder(
                  itemCount: _TitleTask.length,
                    itemBuilder: (context, index) {
                    return Dismissible(
                        key: Key(_TitleTask[index]),
                        background: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16.0),
                          color: Colors.grey,
                        child: Icon(Icons.edit, color: Colors.white),
                    ),// container background from key dimissible
                      secondaryBackground: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 16.0),
                        color: Colors.red,
                        child: Icon(Icons.delete, color: Colors.white),
                      ),// container of secondary background
                      confirmDismiss: (direction) async{
                       if (direction == DismissDirection.endToStart){
                         Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) =>
                             DeleteTaskPage(taskID: _TitleTask[index])),
                         );// navigator push of confirm dimisss
                       } // close of if direction == dimiss direction.endTostart
                        else if (direction == DismissDirection.startToEnd){
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (_) {
                              return Container(
                                height: 550,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2e3253).withOpacity(0.4),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20, right: 20
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => ViewTask(taskTitle: _TitleTask[index])),
                                          );// navigator push
                                        }, // ontap
                                        child: ButtonWidget(
                                          backgroundcolor: AppColors.mainColor,
                                          text: "View Task",
                                          textColor: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => UpdateTask(taskId: _TitleTask[index])),
                                          ); //materialpage route
                                        },//ontap
                                        child: ButtonWidget(
                                          backgroundcolor: AppColors.mainColor,
                                          text: "Edit Task",
                                          textColor: Colors.white,
                                        ),
                                      )
                                    ], //  children in padding child of showmodal
                                  ),
                                ),
                              ); // container return after builder
                              } // builder in showmmodelbottomsheet
                              );// showmodalbottomsheet
                       }// else if direction dimiss
                        else {
                          return Future.delayed(Duration(seconds: 1),()=>direction == DismissDirection.endToStart);
                              };
                      key: ObjectKey(index);
                      }, //confirmDismissible async
                          child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20, bottom:10),
                              child: TaskWidget(
                              text: _TitleTask[index],
                              color: Colors.blueGrey,
                              ),
                              )
                      );
                      }, // item builder  from listview builder
                )
            )
          ] // children of scaffold
      ),
    );
  }}