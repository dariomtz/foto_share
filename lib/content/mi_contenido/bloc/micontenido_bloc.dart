import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foto_share/data/fshare.dart';
import 'package:foto_share/storage/fshare_repository.dart';

part 'micontenido_event.dart';
part 'micontenido_state.dart';

class MicontenidoBloc extends Bloc<MicontenidoEvent, MicontenidoState> {
  final FShareRepository fshareRepo = FShareRepository();

  MicontenidoBloc() : super(MicontenidoInitial()) {
    on<GetAllMyPublicFotosEvent>(_getAllPublicPhotos);
  }

  Future<void> _getAllPublicPhotos(event, emit) async {
    emit(MicontenidoFotosLoadingState());
    try {
      var list = await fshareRepo.retrieveMyPosts(public: true);
      emit(MicontenidoFotosSuccessState(myPublicData: list));
    } catch (e) {
      print("Error al obtener items pblicos: $e");
      emit(MicontenidoFotosErrorState());
      emit(MicontenidoFotosEmptyState());
    }
  }
}
