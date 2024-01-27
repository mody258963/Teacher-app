
import 'package:flutter/widgets.dart';
import 'package:teacher/web_servese/model/course.dart';

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
 final List<Course> posts;

  CourseOfUserState({required this.posts});


}