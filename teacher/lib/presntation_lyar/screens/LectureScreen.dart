import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/besnese_logic/get_method/get_method_cubit.dart';
import 'package:teacher/besnese_logic/get_method/get_method_state.dart';
import 'package:teacher/costanse/colors.dart';
import 'package:teacher/costanse/pages.dart';

class LectureScreen extends StatefulWidget {
  const LectureScreen({super.key});

  @override
  State<LectureScreen> createState() => _LectureScreenState();
}

class _LectureScreenState extends State<LectureScreen> {
  @override
  void initState() {
    context.read<GetMethodCubit>().emitGetAllLectureOfCourse();
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
      if (state is LectureOfCourseState) {
        final allUsersList = state.posts;
        return GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 30,
                mainAxisSpacing: 0.3,
                childAspectRatio:
                    ((width / 0.15) / (height - kToolbarHeight - 24) / 2)),
            itemCount: allUsersList.length,
            itemBuilder: (context, index) {
              final user = allUsersList[index];
              return GridTile(
                header: GridTileBar(
                  title: Text('${user.name.toString()}',
                      style: const TextStyle(color: Colors.black)),
                ),
                child: GestureDetector(
                  onTap: () {
                            Navigator.of(context, rootNavigator: true)
              .pushNamed(lecture);
                  },
                  child: Container(
                      margin: const EdgeInsets.all(12.0),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        gradient: const RadialGradient(
                          colors: <Color>[Color(0x0F88EEFF), Color(0x2F0099BB)],
                        ),
                      ),
                      child: Container()),
                ),
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
                      padding:
                          EdgeInsets.only(top: height * 0.06, right: width * 0.50),
                      child: _title('Lecture', context),
                    ),
                    _buildLectureAllDataTeacher(context)
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
