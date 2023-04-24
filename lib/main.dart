//import 'dart:html'

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layout/news_app/cubit/Cubit.dart';
import 'package:flutter_project/layout/news_app/cubit/States.dart';
import 'package:flutter_project/shared/Components/constants.dart';
import 'package:flutter_project/shared/Network/local/Cache_Helper.dart';
import 'package:flutter_project/shared/Network/remote/Dio_Helper.dart';
import 'package:flutter_project/shared/Styles/themes.dart';
import 'package:flutter_project/shared/bloc_observer.dart';
import 'package:flutter_project/shared/cubit/cubit.dart';
import 'package:flutter_project/shared/cubit/states.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'dart:ui';
import 'layout/news_app/news_layout.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();


  if(Platform.isWindows)
    {
      await DesktopWindow.setMinWindowSize(
          Size(
              600.00,
              600.00
          ),
      );
    }

  dio_helper.init();
  await cache_helper.init();

  saved = cache_helper.getData(key: 'saved') ?? [];
  //print(saved!.length);

  bool? IsDark = cache_helper.GetData(key: 'IsDark');

  runApp(MyApp(IsDark));
}

class MyApp extends StatelessWidget {
  final bool? IsDark;
  MyApp(this.IsDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()..ChangeMode(fromshared: IsDark)),
        BlocProvider(create: (BuildContext context) => NewsCubit()..GetBusiness()..GetSports()..GetScience()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state) {},
        builder: (context,state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: LighteMode,
            darkTheme: DarkMode,
            themeMode: AppCubit.get(context).IsDark ? ThemeMode.dark :  ThemeMode.light,
            //home: News_Screen(),
            home: News_Screen()
          );
          },
      ),
    );
  }
}
