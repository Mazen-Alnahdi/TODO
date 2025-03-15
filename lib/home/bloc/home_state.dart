part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

final class HomeInitial extends HomeState {
  final bool? success;

  HomeInitial({this.success});

  @override
  List<Object?> get props => [success];
}
