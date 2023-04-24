import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layout/news_app/cubit/Cubit.dart';
import 'package:flutter_project/layout/news_app/cubit/States.dart';
import 'package:flutter_project/shared/Components/components.dart';
import 'package:responsive_builder/responsive_builder.dart';

class  Business_Screen extends StatelessWidget {
  const Business_Screen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state) => () {},
      builder: (context,state) {
        var list = NewsCubit.get(context).business;
        return  ScreenTypeLayout(
          mobile: Builder(builder: (context) {
            NewsCubit.get(context).setDesktop(false);
            return ArticleBuilder(list,context);
          },),
          desktop: Builder(
            builder: (context) {
              NewsCubit.get(context).setDesktop(true);
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: ArticleBuilder(list, context)),
                  if(list.length > 0)
                    Expanded(
                    child: Container(
                      color: Colors.grey[300],
                      height: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(20.00),
                        child: Text('${list[NewsCubit
                            .get(context)
                            .selectedBusinessItem]['description']}',
                          style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ),
                  )
                ],
              );
            }
          ),
          breakpoints: ScreenBreakpoints(desktop: 600, tablet: 300, watch: 100),
        );
      },

    );
  }
}
