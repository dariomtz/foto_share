part of 'micontenido_bloc.dart';

abstract class MicontenidoState extends Equatable {
  const MicontenidoState();

  @override
  List<Object> get props => [];
}

class MicontenidoInitial extends MicontenidoState {}

class MicontenidoFotosSuccessState extends MicontenidoState {
  // lista de elementos de firebase "fshare collection"
  final Map<String, FShare> myPublicData;

  const MicontenidoFotosSuccessState({required this.myPublicData});
  @override
  List<Object> get props => [myPublicData];
}

class MicontenidoFotosErrorState extends MicontenidoState {}

class MicontenidoFotosEmptyState extends MicontenidoState {}

class MicontenidoFotosLoadingState extends MicontenidoState {}
