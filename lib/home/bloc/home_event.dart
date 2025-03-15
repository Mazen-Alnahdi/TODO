part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}


class LoginEvent extends HomeEvent {
  final String username;
  final String password;

  LoginEvent(this.username, this.password);

  @override
  // TODO: implement props
  List<Object?> get props => [username,password];

}