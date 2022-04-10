part of 'agregar_bloc.dart';

abstract class AgregarState extends Equatable {
  const AgregarState();

  @override
  List<Object> get props => [];
}

class AgregarImageNotSelected extends AgregarState {}

class AgregarImageSelected extends AgregarState {
  final XFile image;

  AgregarImageSelected({
    required this.image,
  });

  @override
  List<Object> get props => [image];
}

class AgregarLoading extends AgregarState {}
