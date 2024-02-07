import 'package:flutter/material.dart ';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher/besnese_logic/get_method/get_method_cubit.dart';
import 'package:teacher/besnese_logic/get_method/get_method_state.dart';
import 'package:teacher/costanse/colors.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetMethodCubit>().emitGetAllCourseOfTeacher();
  }

  Widget _title(String title, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Text(title,
        style: TextStyle(color: Colors.white, fontSize: width * 0.12));
  }

  Widget _buildGetAllDataSumbit(BuildContext context) {
  PersistentBottomSheetController<void> _buttomsheet() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold.of(context).showBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ), (BuildContext context) {
      return Container(
        height: height * 0.90,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[_buildLectureAllDataTeacher(context)],
          ),
        ),
      );
    });
  }

  Widget _buildLectureAllDataTeacher(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<GetMethodCubit, GetMethodState>(
        builder: (context, state) {
      if (state is LectureOfCourseState) {
        final allUsersList = state.posts;
        return SizedBox(
          height: height * 0.767,
          width: width * 0.95,
          child: ListView.builder(
              itemCount: allUsersList.length,
              itemBuilder: (context, index) {
                final user = allUsersList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.yellowAccent),
                    height: height * 0.20,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user.title.toString(),
                            style: TextStyle(fontSize: width * 0.10),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('==============fododod');
                            },
                          )
                        ],
                      ),

                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.yellowAccent),
                      height: height * 0.20,
                      child: Text(user.title.toString()),
                    ),
                  ),
                );
              }),
        );
      }

      return Container();
    });
  }

  Widget _buildCourseAllDataTeacher(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<GetMethodCubit, GetMethodState>(
        builder: (context, state) {
      if (state is CourseOfTeacherState) {
        final allUsersList = state.posts;
        return SizedBox(
          height: height * 0.767,
          width: width * 0.95,
          child: ListView.builder(
              itemCount: allUsersList.length,
              itemBuilder: (context, index) {
                final user = allUsersList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      _buttomsheet();
                      context
                          .read<GetMethodCubit>()
                          .emitGetAllLectureOfCourse();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.yellowAccent),
                      height: height * 0.20,
                      child: Text(user.title.toString()),
                    ),
                  ),
                );
              }),
        );
      }
      return Container();
    });
  }

  // Widget _Gester(title) {
  //   double width = MediaQuery.of(context).size.width;
  //   double height = MediaQuery.of(context).size.height;
  //   return Container(
  //     color: Colors.blueAccent,
  //     height: height * 0.30,
  //     width: width * 0.80,
  //     child: Column(
  //       children: [Text(title),
  //       Text(),
  //         GestureDetector(

  //           onTap: () {

  //           },

  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
          backgroundColor: MyColors.backcolor,
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.06, right: width * 0.50),
                  child: _title('Course', context),
                ),
                _buildCourseAllDataTeacher(context)
              ],
            ),
          )),
    );
  }
}
