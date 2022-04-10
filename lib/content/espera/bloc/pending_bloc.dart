import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foto_share/data/fshare.dart';
import 'package:foto_share/storage/fshare_repository.dart';

part 'pending_event.dart';
part 'pending_state.dart';

class PendingBloc extends Bloc<PendingEvent, PendingState> {
  final FShareRepository fshareRepo = FShareRepository();

  PendingBloc() : super(PendingInitial()) {
    on<GetAllMyDisabledFotosEvent>(_getMyDisabledContent);
  }

  FutureOr<void> _getMyDisabledContent(event, emit) async {
    emit(PendingFotosLoadingState());
    try {
      var myDisabledContentList =
          await fshareRepo.retrieveMyPosts(public: false);
      // lista de documentos filtrados del usuario con sus datos de fotos en espera
      emit(PendingFotosSuccessState(myDisabledData: myDisabledContentList));
    } catch (e) {
      print("Error al obtener items en espera: $e");
      emit(PendingFotosErrorState());
      emit(PendingFotosEmptyState());
    }
  }
}
