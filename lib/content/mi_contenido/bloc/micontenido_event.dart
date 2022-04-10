part of 'micontenido_bloc.dart';

abstract class MicontenidoEvent extends Equatable {
  const MicontenidoEvent();

  @override
  List<Object> get props => [];
}

class GetAllMyPublicFotosEvent extends MicontenidoEvent {}
