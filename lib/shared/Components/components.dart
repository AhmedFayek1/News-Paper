
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/shared/cubit/cubit.dart';

import '../../layout/news_app/cubit/Cubit.dart';
import '../../layout/news_app/cubit/States.dart';
import '../../modules/News_App/Web_View/web_view.dart';

Widget NewsBuilder(article,context,index)
{
  return Container(
    color: NewsCubit.get(context).selectedBusinessItem == index && NewsCubit.get(context).isDesktop! ? Colors.grey[300] : null,
    child: InkWell(
      onTap: ()
      {
        !NewsCubit.get(context).isDesktop! ?
          Navigateto(context,WebViewScreen(article['url'])) :
          NewsCubit.get(context).changeSelectedItem(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            article['urlToImage'] != null ?
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.00)),
                    image: DecorationImage(
                    image: NetworkImage("${article['urlToImage']}"),
                    fit: BoxFit.cover,
                  ),
            ),
            ): Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.00)),
                image: DecorationImage(
                  image: NetworkImage("http://www.hasaangilmer.com/wp-content/uploads/2021/07/latestnews.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 20,),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: Text("${article['title']}",style: Theme.of(context).textTheme.bodyText1)),
                    SizedBox(width: 5.00,),
                    Text("${article['publishedAt']}"),
                    SizedBox(width: 5.00,),
                    IconButton(onPressed: () {
                      NewsCubit.get(context).savedNews(article);
                    }, icon: Icon(Icons.save_alt))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget Separator()
{
  return  Container(
    width: double.infinity,
    height: 1.00,
    color: Colors.grey[300],
  );
}


Widget ArticleBuilder(list,context,{IsSearch = false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context,index) => NewsBuilder(list[index],context,index),
    separatorBuilder: (context,index) => Separator(),
    itemCount: list.length,
  ),
  fallback: (context) => IsSearch ? Container() : Center(child: CircularProgressIndicator()),
);



void Navigateto(context,widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget)
  );