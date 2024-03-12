import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/besnese_logic/get_method/get_method_cubit.dart';
import 'package:teacher/besnese_logic/get_method/get_method_state.dart';
import 'package:teacher/besnese_logic/uploding_data/uploding_data_cubit.dart';
import 'package:teacher/besnese_logic/uploding_data/uploding_data_state.dart';
import 'package:teacher/costanse/colors.dart';
import 'package:teacher/costanse/pages.dart';

class LectureScreen extends StatefulWidget {
  const LectureScreen({super.key, required course_id});

  @override
  State<LectureScreen> createState() => _LectureScreenState();
}

class _LectureScreenState extends State<LectureScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<GetMethodCubit>(context).emitGetAllLectureOfCourse();
    super.initState();
  }

  Widget _title(String title, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Text(title,
        style: TextStyle(color: Colors.white, fontSize: width * 0.12));
  }

  
  Widget _textFild(String text, int lines, TextEditingController _controller) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
          left: width * 0.03,
          right: width * 0.03,
          top: height * 0.03,
          bottom: height * 0.02),
      child: TextField(
        controller: _controller,
        maxLines: lines,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(color: Colors.white),
          focusColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(width: 5, color: Colors.white),
          ),
          fillColor: Colors.white,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.white),
          ),
        ),
      ),
    );
  }

 Widget _buildBottemsheetContent() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        _textFild('Title', 1, titleController),
        _textFild('Description', 3, descriptionController),
        Container(
          height: height * 0.10,
          width: width * 0.80,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12), // Adjust the border radius for circular shape
                    ),
                    backgroundColor: Colors.white),
                onPressed: () {
                  context.read<UplodingDataCubit>().uploadLectureAndSaveUrls(
                      titleController.text,
                      descriptionController.text,
                      
                      );
                },
                child: Text(
                  'Add Course',
                  style: TextStyle(color: Colors.black),
                )),
          ),
        ),
      ],
    );
  }
  Widget _buildCircularProgressIndicatorDialog(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Takes the full width
      height: MediaQuery.of(context).size.height * 0.70,
      child: Center(child: Image.asset('assets/icons/lolo.gif')),
    );
  }

// This function shows the dialog.
  void _showCircularProgressIndicatorDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      builder: (BuildContext context) {
        // Call the widget-building function here.
        return _buildCircularProgressIndicatorDialog(context);
      },
    );
  }
  void _showSuccessDialog(BuildContext context, String message) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
            titleController.clear();
            descriptionController.clear();
               Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

   Widget _buildlistiner() {
    return BlocListener<UplodingDataCubit, UplodingDataState>(
      listener: (context, state) {
        if (state is Uploaded) {

          _showSuccessDialog(
              context, 'Your data has been uploaded successfully');

            
        } else if (state is Error) {
          _showErrorDialog(context, 'Erorr');
        }
      },
      child: BlocBuilder<UplodingDataCubit, UplodingDataState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(
              child: _buildCircularProgressIndicatorDialog(context),
            );
          }
          // Return your main widget here
          return _buildBottemsheetContent();
        },
      ),
    );
  }

   Widget _buildBottomSheet(
    BuildContext context,
    ScrollController scrollController,
    double bottomSheetOffset,
  ) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            titleController.clear();
            descriptionController.clear();
            BlocProvider.of<GetMethodCubit>(context)
                .emitGetAllCourseOfTeacher();
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Cairo'),
          home: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: MyColors.backcolor),
            child: ListView(
                controller: scrollController,
                children: [Center(child: _buildlistiner())]),
          ),
        ));
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
              return _contaner(user);
            });
      }
      return Container();
    });
  }

  Widget _contaner(user) {
    return ExpansionTile(
      title: Text('ExpansionTile 3'),
      subtitle: Text('Leading expansion arrow icon'),
      controlAffinity: ListTileControlAffinity.leading,
      children: <Widget>[
        ListTile(title: Text('This is tile number 3')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          BlocProvider.of<GetMethodCubit>(context).emitGetAllCourseOfTeacher();
        }
      },
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Cairo'),
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.backcolor,
              title: _title('Lecture', context),
            ),
             floatingActionButton: FloatingActionButton(
            onPressed: () {
              BlocProvider.of<GetMethodCubit>(context).emitGetAllCatogry();
              showFlexibleBottomSheet(
                  bottomSheetColor: MyColors.backcolor,
                  minHeight: 0,
                  initHeight: 0.5,
                  maxHeight: 1,
                  context: context,
                  builder: _buildBottomSheet,
                  anchors: [0, 0.5, 1],
                  isSafeArea: true,
                  bottomSheetBorderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)));
            },
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              color: MyColors.backcolor,
            ),
          ),
            backgroundColor: MyColors.backcolor,
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [_buildLectureAllDataTeacher(context)],
                ),
              ),
            )),
      ),
    );
  }
}
