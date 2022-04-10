import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foto_share/data/fshare.dart';
import 'package:foto_share/storage/fshare_repository.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FShareRepository fshareRepo = FShareRepository();

  FeedBloc() : super(FeedInitial()) {
    on<FeedEvent>(_getFeed);
  }

  Future<void> _getFeed(event, emit) async {
    emit(FeedLoadingState());
    try {
      var list = await fshareRepo.retrieveFeed();

      emit(FeedSuccessState(feed: list));
    } catch (e) {
      print("Error al obtener feed: $e");
      emit(FeedErrorState());
      emit(FeedEmptyState());
    }
  }
}
