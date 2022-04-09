part of 'agregar_bloc.dart';

abstract class AgregarState extends Equatable {
  const AgregarState();

  @override
  List<Object> get props => [];
}

class AgregarInitial extends AgregarState {}

class AgregarLoading extends AgregarState {}
