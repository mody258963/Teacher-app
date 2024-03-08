import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher/besnese_logic/email_auth/email_auth_cubit.dart';
import 'package:teacher/besnese_logic/get_method/get_method_state.dart';
import 'package:teacher/web_servese/model/course.dart';
import 'package:teacher/web_servese/model/lecture.dart';
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
      List<Data> posts =
          await myRepo.getAllCourseOfUser('get-course/user/$id');
      print('===posts====$posts');
      emit(CourseOfUserState(posts: posts));
    } catch (e) {
      emit(Coursefails(e.toString()));
      print('========cubits=======${e.toString()}');
    }
  }

  Future<FutureOr<void>> emitGetAllCourseOfTeacher() async {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('user_id');
    emit(LodingState());
    try {
      print('======get=======$id');
      List<Data> posts =
          await myRepo.getAllCourseOfTeacher('get-course/teacher/$id');
      int? result = posts.first.id;
      print(result);
      prefs.remove('course_id');
      prefs.setInt('course_id', result);

      print('===posts====$result');
    
      emit(CourseOfTeacherState(posts: posts));
    } catch (e) {
      emit(Coursefails(e.toString()));
      print('========cubits=======${e.toString()}');
    }
  }

  Future<FutureOr<void>> emitGetAllLectureOfCourse() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getInt('course_id');

      emit(LodingState());
      List<Lecture> posts =
          await myRepo.getAllLectureOfCourse('get-all/lecture/$id');

      print('===posts2====$posts');
      emit(LectureOfCourseState(posts: posts));
    } catch (e) {
      emit(Coursefails(e.toString()));
      print('========cubits=======${e.toString()}');
    }
  }

  Future<FutureOr<void>> emitGetAllCatogry() async {
    try {
      emit(LodingState());
      List<dynamic> posts = await myRepo.getAllCatogory('get/category');

      print('===category====$posts');
      emit(CatogoryState(posts: posts));
    } catch (e) {
      emit(Coursefails(e.toString()));
      print('========cubits=======${e.toString()}');
    }
  }
}
// emit(state.copyWith(isLoading: true));
	