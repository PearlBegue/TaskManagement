import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golang_yt/colors/app_colors.dart';
import 'package:flutter_golang_yt/screens/add_task.dart';
import 'package:flutter_golang_yt/screens/all_task.dart';



import '../widgets/button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(left:20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: "Task Managment",
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                    ),
                  children: [
                  TextSpan(
                  text: "\nYour Choice Is Your History",
                  style: TextStyle(
                      color: AppColors.smallTextColor,
                      fontSize: 20,
                  )
                  )]
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/2.5,),
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddTask()),
                );
                },
              child: ButtonWidget(backgroundcolor: AppColors.mainColor,
                  text: "Add Task",
                  textColor: Colors.white),
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllTasks()),
                );
              },


              child: ButtonWidget(backgroundcolor: Colors.white,
                  text: "All Tasks",
                  textColor: AppColors.smallTextColor),
            )
          ],
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
              image: AssetImage(
                      "assets/welcome.jpg")
          )
        ),
      ),
    );
  }
}
