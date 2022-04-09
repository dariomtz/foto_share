part of 'agregar_bloc.dart';

abstract class AgregarEvent extends Equatable {
  const AgregarEvent();

  @override
  List<Object> get props => [];
}

class AgregarSubmit extends AgregarEvent {
  final String picture;
  final String title;
  final bool public;

  const AgregarSubmit({
    required this.picture,
    required this.title,
    required this.public,
  });

  @override
  List<Object> get props => [picture, title, public];
}
