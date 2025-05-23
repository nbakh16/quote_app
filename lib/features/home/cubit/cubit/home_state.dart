part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class QuoteInitial extends HomeState {}

class Loading extends HomeState {}

class QuotesLoaded extends HomeState {
  final List<QuoteModel> quotes;

  const QuotesLoaded(this.quotes);
}

class QuoteCreated extends HomeState {}

class Error extends HomeState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}

class Logout extends HomeState {}
