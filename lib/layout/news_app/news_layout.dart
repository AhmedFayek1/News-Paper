import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layout/news_app/cubit/Cubit.dart';
import 'package:flutter_project/layout/news_app/cubit/States.dart';
import 'package:flutter_project/shared/Network/remote/Dio_Helper.dart';
import 'package:flutter_project/shared/cubit/cubit.dart';

import '../../modules/News_App/Search/search.dart';
import '../../shared/Components/components.dart';


class News_Screen extends StatelessWidget {
  const News_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state) {},
      builder: (context,state) {
        var cubit = NewsCubit.get(context);

        return Scaffold(
        appBar: AppBar(
          title: Text("News App"),
          actions: [
             IconButton(
                 onPressed: () {
                   Navigateto(context, Search_Screen());
                 },
                 icon: Icon(Icons.search),
             ) ,
            IconButton(
              icon: Icon(Icons.brightness_4_outlined),
              onPressed: () {
                AppCubit.get(context).ChangeMode();
              },
            ) ,
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.Current_Index,
            onTap: (index)
            {
              cubit.ChangeNavBar(index);
            },
            items: cubit.BottomItems,
        ),
          body: cubit.news_screens[cubit.Current_Index],
      );
      },
    );
  }
}
