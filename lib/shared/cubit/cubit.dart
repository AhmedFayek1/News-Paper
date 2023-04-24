//import 'dart:html'

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/shared/Network/local/Cache_Helper.dart';
import 'package:flutter_project/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';



class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool IsDark = false;

  void ChangeMode({bool? fromshared}) {
    if (fromshared != null) {
      IsDark = fromshared;
      emit(ChangeAppModeState());
    }
    else {
      IsDark = !IsDark;
      cache_helper.PutData(key: 'IsDark', value: IsDark).then((value) {
        emit(ChangeAppModeState());
      });
    }
          }
}
