
import 'package:flutter/widgets.dart';
import 'package:teacher/web_servese/model/catogry.dart';
import 'package:teacher/web_servese/model/course.dart';
import 'package:teacher/web_servese/model/lecture.dart';

import '../../web_servese/model/username.dart';

@immutable
sealed class GetMethodState {}

class GetMethodInitial extends GetMethodState {}

class LodingState extends GetMethodState{}

class AllItemsState extends GetMethodState {
 final List<User> posts;

  AllItemsState({required this.posts});


}

class CourseOfUserState extends GetMethodState {
 final List<Data> posts;

  CourseOfUserState({required this.posts});


}

class CourseOfTeacherState extends GetMethodState {
 final List<Data> posts;

  CourseOfTeacherState({required this.posts});


}

class LectureOfCourseState extends GetMethodState {
 final List<Lec> posts;

  LectureOfCourseState({required this.posts});


}

class CatogoryState extends GetMethodState {
 final List<dynamic>  posts;

  CatogoryState({required this.posts});


}
class Coursefails extends GetMethodState{
  final String  message ;

  Coursefails(this.message);

}