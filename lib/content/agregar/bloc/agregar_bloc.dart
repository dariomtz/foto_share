import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foto_share/storage/fshare_repository.dart';

part 'agregar_event.dart';
part 'agregar_state.dart';

class AgregarBloc extends Bloc<AgregarEvent, AgregarState> {
  AgregarBloc() : super(AgregarInitial()) {
    on<AgregarSubmit>(_addPost);
  }

  Future<void> _addPost(AgregarSubmit event, emit) async {
    FShareRepository fshareRepo = FShareRepository();
    emit(AgregarLoading());
    await fshareRepo.create(event.title, event.picture, event.public);
    emit(AgregarInitial());
  }
}
