
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/modules/News_App/Saved_News/Saved_News.dart';
import 'package:flutter_project/shared/Network/local/Cache_Helper.dart';

import 'package:flutter_project/shared/Network/remote/Dio_Helper.dart';
import '../../../Models/Model.dart';
import '../../../modules/News_App/Busness/Busness_Screen.dart';
import '../../../modules/News_App/Science/Science_Screen.dart';
import '../../../modules/News_App/Sports/Sports_Screen.dart';
import '../../../shared/Components/constants.dart';
import 'States.dart';
class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(AppInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int Current_Index = 0;

  List<BottomNavigationBarItem> BottomItems =
      [
        BottomNavigationBarItem(
            icon: Icon(Icons.business),
          label: "business",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sports),
          label: "Sports",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.science),
          label: "Science",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.save_alt_outlined),
          label: "Saved",
        ),

      ];

  List<Widget> news_screens= [
    Business_Screen(),
    Sports_Screen(),
    Science_Screen(),
    SavedNews(),
  ];

  void ChangeNavBar(index)
  {
    Current_Index = index;
    if(index == 1) GetSports();
    if(index == 2) GetScience();
    emit(AppChangeBottomNavBar());
  }

  List<dynamic> business = [];
  int selectedBusinessItem = 0;
  bool? isDesktop;
  void GetBusiness()
  {
    emit(GetBusinessLoadingState());
    dio_helper.get_data(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apikey':'9d0fcc070e6e44348e051fffddd6e3e7'
        }
    ).then((value) {
      //print(value.data['articles'][0]['titles']);
      business = value.data['articles'];
      emit(GetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetBusinessErrorState(error.toString()));
    });
  }

  void setDesktop(bool value)
  {
    isDesktop = value;
    emit(SetDesktopState());
  }

  void changeSelectedItem(index)
  {
    selectedBusinessItem = index;
    emit(ChangeSelectedItemState());
  }


  List<dynamic> Sports = [];

  void GetSports() {
    emit(GetSportsLoadingState());

    if (Sports.length == 0) {
      dio_helper.get_data(
          url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'Sports',
            'apikey': '9d0fcc070e6e44348e051fffddd6e3e7'
          }
      ).then((value) {
        //print(value.data['articles'][0]['titles']);
        Sports = value.data['articles'];
        emit(GetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetSportsErrorState(error.toString()));
      });
    }
    else {
      emit(GetSportsSuccessState());
    }
  }


  List<dynamic> Science = [];

  void GetScience() {
    emit(GetScienceLoadingState());

    if (Science.length == 0) {
      dio_helper.get_data(
          url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'Science',
            'apikey': '9d0fcc070e6e44348e051fffddd6e3e7'
          }
      ).then((value) {
        //print(value.data['articles'][0]['titles']);
        Science = value.data['articles'];
        emit(GetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetScienceErrorState(error.toString()));
      });
    }
    else {
      emit(GetScienceSuccessState());
    }
  }

  List<dynamic> Search = [];

  void GetSearch(String value) {
    emit(GetSearchLoadingState());

      dio_helper.get_data(
          url: 'v2/everything',
          query: {
            'q': '$value',
            'apikey': '65f7f556ec76449fa7dc7c0069f040ca'
          }
      ).then((value) {
        //print(value.data['articles'][0]['titles']);
        Search = value.data['articles']; 
        print(Search[0]['title']);
        emit(GetSearchSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetSearchErrorState(error.toString()));
      });

  }

  //saved = cache_helper.saveData('savedSounds',saved) ?? []; 
  late News news; 
  List<News> Articles = [];
  savedNews(dynamic article)
  {
    //cache_helper.getData(key: 'saved');
    bool flag = false;
    saved?.forEach((element) {
      if(element == article)  flag = true;
    });
    if(!flag)
      {
        saved.add(article);
        print(news.title);
      }
    emit(GetSavedNewsSuccessState());
  }

}