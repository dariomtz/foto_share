import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:foto_share/content/feed/bloc/feed_bloc.dart';
import 'package:foto_share/content/generalWidgets/others_fshare.dart';

class Feed extends StatelessWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, state) {
        if (state is FeedErrorState) {
          // show snackbar
        }
      },
      builder: (context, state) {
        if (state is FeedLoadingState) {
          return ListView.builder(
            itemCount: 25,
            itemBuilder: (BuildContext context, int index) {
              return YoutubeShimmer();
            },
          );
        } else if (state is FeedEmptyState) {
          return Center(child: Text("No hay datos por mostrar"));
        } else if (state is FeedSuccessState) {
          return ListView.builder(
            itemCount: state.feed.length,
            itemBuilder: (BuildContext context, int index) {
              String key = state.feed.keys.elementAt(index);
              return OthersShare(
                fshare: state.feed[key]!,
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
