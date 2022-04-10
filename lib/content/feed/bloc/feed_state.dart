part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class FeedInitial extends FeedState {}

class FeedSuccessState extends FeedState {
  // lista de elementos de firebase "fshare collection"
  final Map<String, FShare> feed;

  const FeedSuccessState({required this.feed});
  @override
  List<Object> get props => [feed];
}

class FeedErrorState extends FeedState {}

class FeedEmptyState extends FeedState {}

class FeedLoadingState extends FeedState {}
