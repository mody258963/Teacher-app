import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<GetMethodCubit, GetMethodState>(
        builder: (context, state) {
      if (state is CourseOfTeacherState) {
        final allUsersList = state.posts;
        return SizedBox(
          height: 500,
          child: ListView.builder(
              itemCount: allUsersList.length,
              itemBuilder: (context, index) {
                final user = allUsersList[index];
                return ListTile(
                  title: Text(user.title.toString()),
                  subtitle: Text(user.description.toString()),
                );
              }),
        );
      }
      return Container();
    });
  }

  Widget _Gester() {
    return GestureDetector();
  }

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
                Padding(
                  padding:  EdgeInsets.only(top: height * 0.15 ),
                  child: Container(child: _buildGetAllDataSumbit(context)),
                )
              ],
            ),
          )),
    );
  }
}
