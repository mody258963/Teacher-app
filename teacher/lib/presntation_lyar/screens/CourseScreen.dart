import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher/besnese_logic/get_method/get_method_cubit.dart';
import 'package:teacher/besnese_logic/get_method/get_method_state.dart';
import 'package:teacher/costanse/colors.dart';
import 'package:teacher/costanse/pages.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  void initState() {
    BlocProvider.of<GetMethodCubit>(context).emitGetAllCourseOfTeacher();
    super.initState();
  }

  Widget _title(String title, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Text(title,
        style: TextStyle(color: Colors.white, fontSize: width * 0.12));
  }

  Widget _buildLectureAllDataTeacher(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<GetMethodCubit, GetMethodState>(
        builder: (context, state) {
      if (state is LodingState) {
        const CircularProgressIndicator();
      }
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
                                  user.name.toString(),
                                  style: TextStyle(fontSize: width * 0.10),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print('==============fododod');
                                  },
                                )
                              ],
                            ),
                          )));
                }));
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
        return GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 30,
                mainAxisSpacing: 0.3,
                childAspectRatio:
                    ((width / 0.20) / (height - kToolbarHeight - 24) / 2)),
            itemCount: allUsersList.length,
            itemBuilder: (context, index) {
              final user = allUsersList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pushNamed(lecture);
                  BlocProvider.of<GetMethodCubit>(context)
                      .emitGetAllLectureOfCourse();
                },
                child: Container(
                    margin: const EdgeInsets.all(20.0),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      gradient: const RadialGradient(
                        colors: <Color>[Color(0x0F88EEFF), Color(0x2F0099BB)],
                      ),
                    ),
                    child: Center(
                        child: Column(
                      children: [
                        Container(
                          height: height * 0.21,
                          decoration: ShapeDecoration(
                            image: DecorationImage(image: NetworkImage('https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg'),fit: BoxFit.cover),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                              ),
                              ),
                              
                        )
                      ],
                    ))),
              );
            });
      }
      return Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
          backgroundColor: MyColors.backcolor,
          body: ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.06, right: width * 0.50),
                      child: _title('Course', context),
                    ),
                    _buildCourseAllDataTeacher(context),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
