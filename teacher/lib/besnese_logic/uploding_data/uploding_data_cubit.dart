import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    Future<void> uploadImagesAndSaveUrls(List<File> images) async {
      emit(Loading());
      try {} catch (error) {}
    }
  }
}
