import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher/besnese_logic/email_auth/email_auth_cubit.dart';
import 'package:teacher/besnese_logic/get_method/get_method_state.dart';
import 'package:teacher/web_servese/model/course.dart';
import 'package:teacher/web_servese/model/lecture.dart';
import 'package:teacher/web_servese/model/teacherCourse.dart';
import 'package:teacher/web_servese/reproserty/myRepo.dart';

import '../../web_servese/model/username.dart';

class GetMethodCubit extends Cubit<GetMethodState> {
  final MyRepo myRepo;
  List<User>? myallUsers;
  EmailAuthCubit emailAuthCubit;
  GetMethodCubit(this.myRepo, this.emailAuthCubit) : super(GetMethodInitial());

  Future<FutureOr<void>> emitGetAllUSers() async {
    try {
      emit(LodingState());
      List<User> posts = await myRepo.getAllUsers('all-user');
      emit(AllItemsState(posts: posts));
    } catch (e) {
      print('========cubits=======${e.toString()}');
    }
  }

  Future<FutureOr<void>> emitGetAllCourseOfUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('user_id');
      print('======get=======$id');
      emit(LodingState());
      List<Course> posts =
          await myRepo.getAllCourseOfUser('get-course/user/$id');
      print('===posts====$posts');
      emit(CourseOfUserState(posts: posts));
    } catch (e) {
      print('========cubits=======${e.toString()}');
    }
  }

  Future<FutureOr<void>> emitGetAllCourseOfTeacher() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('user_id');
      print('======get=======$id');
      emit(LodingState());
      List<TecherCourse> posts =
          await myRepo.getAllCourseOfTeacher('get-course/teacher/$id');
                int? result = posts.first.id;
      prefs.setInt('course_id', result);

      print('===posts====$result');
      emit(CourseOfTeacherState(posts: posts));
    } catch (e) {
      print('========cubits=======${e.toString()}');
    }
  }

  Future<FutureOr<void>> emitGetAllLectureOfCourse() async {
    try {
      print('======get=======');
          final prefs = await SharedPreferences.getInstance();
            final id = prefs.getInt('course_id');

      emit(LodingState());
      List<Lecture> posts =
          await myRepo.getAllLectureOfCourse('get-all/lecture/$id');

      print('===posts2====$posts');
      emit(LectureOfCourseState(posts: posts));
    } catch (e) {
      print('========cubits=======${e.toString()}');
    }
  }
}
// emit(state.copyWith(isLoading: true));
	