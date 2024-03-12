import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher/web_servese/reproserty/myRepo.dart';
import 'uploding_data_state.dart';

class UplodingDataCubit extends Cubit<UplodingDataState> {
  final MyRepo myRepo;
  UplodingDataCubit(this.myRepo) : super(UplodingDataInitial());

  final List<String> UrlPhotos = [];

  Future<void> uploadAudio(File? data, String title, String id) async {
    emit(Loading());
    try {
      print('===uspload=====$id');
      emit(GetDataFromUi(data: data));
      FormData formData = FormData.fromMap({
        'file_path': await MultipartFile.fromFile(
          data!.path,
        ),
        'title': title,
      });
      List<dynamic> getfile =
          await myRepo.audioUpload('audios/store/$id', formData);
    } catch (e) {}
  }

  Future<void> uploadImagesAndSaveUrls(File? image, String title, String book,
      String description, int category) async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('user_id');
    print('-==========id======= $id');
    emit(Loading());
    try {
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          image!.path,
        ),
        'title': title,
        'book': book,
        'description': description,
      });
      List<dynamic> getfile =
          await myRepo.CourseUpload('add-course/$category/$id', formData);
          
      await Future.delayed(const Duration(seconds: 2));
      if (getfile.isEmpty) {
        return print('=============erorr1=======');
      } else {
        emit(Uploaded());
      }
    } catch (error) {
      print('===========eroor==============${error.toString()}');
      emit(ErrorOccurred(errorMsg: error.toString()));
    }
  }

    Future<void> uploadLectureAndSaveUrls(String title,
      String description) async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('course_id');
    print('==========id Lecture======= $id');
    emit(Loading());
    try {
      FormData formData = FormData.fromMap({
        'title': title,
        'description': description,
      });
      List<dynamic> getfile =
          await myRepo.LectureUpload('/add-lecture/$id', formData);
          
      await Future.delayed(const Duration(seconds: 2));
      if (getfile.isEmpty) {
        return print('=============erorr2=======');
      } else {
        emit(Uploaded());
      }
    } catch (error) {
      print('===========eroor==============${error.toString()}');
      emit(ErrorOccurred(errorMsg: error.toString()));
    }
  }
}
