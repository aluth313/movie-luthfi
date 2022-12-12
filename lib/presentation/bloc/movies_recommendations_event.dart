part of 'movies_recommendations_bloc.dart';

abstract class MoviesRecommendationsEvent extends Equatable {
  const MoviesRecommendationsEvent();

  @override
  List<Object> get props => [];
}

class FetchRecommendations extends MoviesRecommendationsEvent {
  final int id;

  FetchRecommendations(this.id);

  @override
  List<Object> get props => [id];
}
