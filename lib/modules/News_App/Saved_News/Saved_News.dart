import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/news_app/cubit/Cubit.dart';
import '../../../layout/news_app/cubit/States.dart';
import '../../../shared/Components/components.dart';
import '../../../shared/Components/constants.dart';


class SavedNews extends StatelessWidget {
  const SavedNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state) => () {},
      builder: (context,state) {
        var list = saved;
        return  ArticleBuilder(list,context);
      },

    );
  }
}
