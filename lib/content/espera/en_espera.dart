import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:foto_share/content/espera/bloc/pending_bloc.dart';
import 'package:foto_share/content/generalWidgets/my_fshare.dart';

class EnEspera extends StatelessWidget {
  const EnEspera({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PendingBloc, PendingState>(
      listener: (context, state) {
        if (state is PendingFotosErrorState) {
          // show snackbar
        }
      },
      builder: (context, state) {
        if (state is PendingFotosLoadingState) {
          return ListView.builder(
            itemCount: 25,
            itemBuilder: (BuildContext context, int index) {
              return YoutubeShimmer();
            },
          );
        } else if (state is PendingFotosEmptyState) {
          return Center(child: Text("No hay datos por mostrar"));
        } else if (state is PendingFotosSuccessState) {
          return ListView.builder(
            itemCount: state.myDisabledData.length,
            itemBuilder: (BuildContext context, int index) {
              String key = state.myDisabledData.keys.elementAt(index);
              return MyFShare(
                fshare: state.myDisabledData[key]!,
                fshareId: key,
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
