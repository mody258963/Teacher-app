
import 'package:teacher/web_servese/dio/web_serv.dart';
import 'package:teacher/web_servese/model/course.dart';
import 'package:teacher/web_servese/model/lecture.dart';
import 'package:teacher/web_servese/model/username.dart';
import 'package:teacher/web_servese/model/catogry.dart';


class MyRepo {
  final NameWebServise nameWebService;

  MyRepo(this.nameWebService);

  Future<List<User>> getAllUsers(String end) async {
    final names = await nameWebService.get(end);
    final userList = names.map((names) => User.fromJson(names)).toList();
    return userList..shuffle();
  }

  Future<List<Data>> getAllCourseOfUser(String end) async {
    final names = await nameWebService.get(end);
    final courseList = names.map((names) => Data.fromJson(names)).toList();
    return courseList..shuffle();
  }


  Future<List<Data>> getAllCourseOfTeacher(String end) async {
    final names = await nameWebService.get(end);
    final courseList = names.map((names) => Data.fromJson(names)).toList();
    return courseList..shuffle();
  }
    Future<List<Lec>> getAllLectureOfCourse(String end) async {
    final names = await nameWebService.get(end);
    final courseList = names.map((names) => Lec.fromJson(names)).toList();
    return courseList..shuffle();
  }

      Future<List<dynamic>> getAllCatogory(String end) async {
    final names = await nameWebService.get(end);
    final courseList = names.map((names) => Category.fromJson(names)).toList();
    return courseList..shuffle();
  }



  Future<String> login(String end, Object data) async {
    try {
      final result = await nameWebService.post(end, data);

      if (result.isNotEmpty) {
        // final userid = result.map((result) => User.fromJson(result)).toList();
        dynamic firstItem = result[0];
        int userId = firstItem['user_id'];
        String userIdAsString = userId.toString();
        print('login $userIdAsString');
        return userIdAsString;
      } else {
        throw Exception("Invalid response format: Empty response");
      }
    } catch (e) {
      print("Error during login: ${e.toString()}");
      throw Exception("Failed to login. Please try again.");
    }
  }

  Future<String> SignUpTeacher(String end, Object data) async {
    try {
      final result = await nameWebService.post(end, data);

      if (result.isNotEmpty) {
        // final userid = result.map((result) => User.fromJson(result)).toList();
        dynamic firstItem = result[0];
        int userId = firstItem['user_id'];
        String userIdAsString = userId.toString();
        print('signUp $userIdAsString');
        return userIdAsString;
      } else {
        throw Exception("Invalid response format: Empty response");
      }
    } catch (e) {
      print("Error during login: ${e.toString()}");
      throw Exception("Failed to login. Please try again.");
    }
  }

  Future<List<User>> audioUpload(String end, Object data) async {
    try {
      final result = await nameWebService.post(end, data);

      if (result.isNotEmpty) {
        final audio = result.map((audio) => User.fromJson(audio)).toList();
        return audio..shuffle();
      } else {
        throw Exception("Invalid response format: Empty response");
      }
    } catch (e) {
      print("Error during login: ${e.toString()}");
      throw Exception("Failed to login. Please try again.");
    }
  }
    Future<List<Data>> CourseUpload(String end, Object data) async {
    try {
      final result = await nameWebService.post(end, data);

      if (result.isNotEmpty) {
        final audio = result.map((audio) => Data.fromJson(audio)).toList();
        return audio..shuffle();
      } else {
        throw Exception("Invalid response format: Empty response");
      }
    } catch (e) {
      print("Error during login: ${e.toString()}");
      throw Exception("Failed to login. Please try again.");
    }
  }
    Future<List<Lec>> LectureUpload(String end, Object data) async {
    try {
      final result = await nameWebService.post(end, data);

      if (result.isNotEmpty) {
        final lecture = result.map((lecture) => Lec.fromJson(lecture)).toList();
        return lecture..shuffle();
      } else {
        throw Exception("Invalid response format: Empty response");
      }
    } catch (e) {
      print("Error during login: ${e.toString()}");
      throw Exception("Failed to login. Please try again.");
    }
  }
}
