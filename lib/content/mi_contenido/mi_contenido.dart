import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:foto_share/content/generalWidgets/my_fshare.dart';
import 'package:foto_share/content/mi_contenido/bloc/micontenido_bloc.dart';

class MiContendo extends StatelessWidget {
  const MiContendo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MicontenidoBloc, MicontenidoState>(
      listener: (context, state) {
        if (state is MicontenidoFotosErrorState) {
          // show snackbar
        }
      },
      builder: (context, state) {
        if (state is MicontenidoFotosLoadingState) {
          return ListView.builder(
            itemCount: 25,
            itemBuilder: (BuildContext context, int index) {
              return YoutubeShimmer();
            },
          );
        } else if (state is MicontenidoFotosEmptyState) {
          return Center(child: Text("No hay datos por mostrar"));
        } else if (state is MicontenidoFotosSuccessState) {
          return ListView.builder(
            itemCount: state.myPublicData.length,
            itemBuilder: (BuildContext context, int index) {
              String key = state.myPublicData.keys.elementAt(index);
              return MyFShare(
                fshare: state.myPublicData[key]!,
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
