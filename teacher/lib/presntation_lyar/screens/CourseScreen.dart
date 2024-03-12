import 'dart:io';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher/besnese_logic/get_method/get_method_cubit.dart';
import 'package:teacher/besnese_logic/get_method/get_method_state.dart';
import 'package:teacher/besnese_logic/uploding_data/uploding_data_cubit.dart';
import 'package:teacher/besnese_logic/uploding_data/uploding_data_state.dart';
import 'package:teacher/costanse/colors.dart';
import 'package:teacher/costanse/pages.dart';
import 'package:teacher/presntation_lyar/screens/LectureScreen.dart';


class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final ImagePicker picker = ImagePicker();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController bookController = TextEditingController();
  String selectedValue = '';
  int selectedId = 0;
  static List<String> items = <String>[];
  File? _selectPhoto;
  @override
  void initState() {
    BlocProvider.of<GetMethodCubit>(context).emitGetAllCourseOfTeacher();
    super.initState();
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

  Future<File?> _pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _selectPhoto = File(image.path);
      print('Selected Audio: ${_selectPhoto!.path}');
      return _selectPhoto;
    } else {
      // User canceled the file picker
      print('No audio file selected');
      return null;
    }
  }

  Widget _dropBox() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<GetMethodCubit, GetMethodState>(
      builder: (context, state) {
        if (state is LodingState) {
          return Center(child: _buildCircularProgressIndicatorDialog(context));
        } else if (state is CatogoryState) {
          items.clear();
          final allist = state.posts;
          for (var data in allist) {
            String formattedString = "${data.id}  ${data.title}";
            items.add(formattedString);
          }
          return DropdownMenu<dynamic>(
            hintText: 'Select Category',
            label: const Text(
              'Catogary',
              style: TextStyle(color: Colors.white),
            ),
            textStyle: TextStyle(color: Colors.white),
            inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                floatingLabelAlignment: FloatingLabelAlignment.start),
            onSelected: (dynamic value) async {
              setState(() {
                selectedId = int.parse(value.split("  ")[0]);
                final selectedTitle = value.split("  ")[1];
                print(selectedId);
                selectedValue = selectedTitle;
              });
            },
            dropdownMenuEntries:
                items.map<DropdownMenuEntry<dynamic>>((dynamic value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          );
        } else {
          // Handle other states if needed
          return Container();
        }
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
            bookController.clear();
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

  Widget _title(String title, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Text(title,
        style: TextStyle(color: Colors.white, fontSize: width * 0.12));
  }

  String checkInput(List<String> validInputs, String userInput) {
    for (String validInput in validInputs) {
      if (userInput.toLowerCase().contains(validInput.toLowerCase())) {
        return 'ar';
      }
    }

    return 'en';
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

  Widget _buildCourseAllDataTeacher(BuildContext context) {
    List<String> validInputs = [
      'س',
      'ج',
      'ح',
      'ي',
      'ب',
      'ل',
      'ا',
      'ت',
      'ن',
      'م',
      'ك',
      'و',
      'د',
      'ذ',
      'ط',
      'غ',
      'ع',
      'ر',
      'ف',
      'ظ',
      'ط',
      'ه',
      'خ'
    ];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<GetMethodCubit, GetMethodState>(
        builder: (context, state) {
      if (state is LodingState || state is GetMethodInitial) {
        return _buildCircularProgressIndicatorDialog(context);
      }
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
              String test = user.title.toString();
              String test1 = user.book.toString();
              final lang = checkInput(validInputs, test);
              final lang1 = checkInput(validInputs, test1);
              return _contaner(user, lang, lang1);
            });
      }
      return Container();
    });
  }

  Widget _buildBottemsheetContent() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            _pickImage();
          },
          child: Container(
            margin: EdgeInsets.only(
                left: width * 0.03,
                right: width * 0.03,
                bottom: height * 0.03,
                top: height * 0.05),
            height: height * 0.13,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Center(
                child: Icon(
              Icons.add,
              color: MyColors.backcolor,
            )),
          ),
        ),
        _dropBox(),
        _textFild('Title', 1, titleController),
        _textFild('Book', 1, bookController),
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
                  context.read<UplodingDataCubit>().uploadImagesAndSaveUrls(
                      _selectPhoto,
                      titleController.text,
                      bookController.text,
                      descriptionController.text,
                      selectedId);
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
            bookController.clear();
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

  Widget _contaner(user, lang, lang1) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(lang);
    return GestureDetector(
      onTap: () {
          PersistentNavBarNavigator.pushNewScreen(
        context,
        screen:  LectureScreen(course_id: user.first.id),
        withNavBar: true, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
        BlocProvider.of<GetMethodCubit>(context).emitGetAllLectureOfCourse();
      },
      child: Container(
          margin: EdgeInsets.all(width * 0.03),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            gradient: const RadialGradient(
              colors: <Color>[Color(0x0F88EEFF), Color(0x2F0099BB)],
            ),
          ),
          child: Column(
            children: [
              Container(
                height: height * 0.19,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: CachedNetworkImage(
      imageUrl: user.image.toString(),
      width: width * 0.95,
      placeholder: (context, url) => _buildCircularProgressIndicatorDialog(context),
      errorWidget: (context, url, error) => Icon(Icons.error),
      fit: BoxFit.cover,
    ),
                ),
              ),
              SizedBox(
                height: height * 0.08,
                child: ListTile(
                    titleTextStyle:
                        TextStyle(fontSize: width * 0.050, fontFamily: 'Cairo'),
                    subtitleTextStyle:
                        TextStyle(fontSize: width * 0.040, fontFamily: 'Cairo'),
                    textColor: Colors.white,
                    title: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          user.title.toString(),
                          textAlign: lang == 'ar' ? TextAlign.right : null,
                        )),
                    subtitle: Text(
                      user.book.toString(),
                      textAlign: lang1 == 'ar' ? TextAlign.right : null,
                    )),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Cairo'),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.backcolor,
            title: _title('Course', context),
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
            child: Column(
              children: [
                _buildCourseAllDataTeacher(context),
              ],
            ),
          )),
    );
  }
}
