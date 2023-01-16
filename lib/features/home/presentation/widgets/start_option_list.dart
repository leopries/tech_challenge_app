import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/nlp_bloc.dart';
import 'list_header.dart';
import 'nlp_input_text_field.dart';

class StartOptionList extends StatelessWidget {
  const StartOptionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NlpBloc>(),
      child: Column(
        children: const [
          ListHeader(),
          //ScrollableOptionList(),
          NLPInputTextField(),
        ],
      ),
    );
  }
}
