
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/layout/news_app/cubit/Cubit.dart';
import 'package:flutter_project/layout/news_app/cubit/States.dart';
import 'package:flutter_project/shared/Components/components.dart';

class Search_Screen extends StatelessWidget {
  const Search_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var SearchController = TextEditingController();
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state) {},
      builder: (context,state) {
        var list = NewsCubit.get(context).Search;
        return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.00),
                          topLeft: Radius.circular(10.00),
                          bottomLeft: Radius.circular(10.00),
                          bottomRight: Radius.circular(10.00),
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: SearchController,
                        onChanged: (value)
                        {
                              NewsCubit.get(context).GetSearch(value);
                        },
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,

                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(child: ArticleBuilder(list, context,IsSearch: true)),
              ],
            )
        );
      },
    );
  }
}
