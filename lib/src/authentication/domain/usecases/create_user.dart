import 'package:equatable/equatable.dart';
import 'package:todo/core/usecase/usecase.dart';
import 'package:todo/core/utils/typedef.dart';
import 'package:todo/src/authentication/domain/repositories/authentication_repository.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams>{
  const CreateUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture call(CreateUserParams params) async  => _repository.createUser(
      createdAt: params.createdAt,
      name: params.name,
      avatar: params.avatar
  );
}

class CreateUserParams extends Equatable {

  CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar
  });

  final String createdAt;
  final String name;
  final String avatar;

  @override

  List<Object?> get props => [createdAt, name,avatar];

}